import Foundation

func decodeBase32( _ input: String) throws -> Data {
    let inputWithoutPadding = input.filter { $0 != "=" }
    let groups = stride(from: 0, to: inputWithoutPadding.count, by: 8)
    let data = try groups
        .map { Reductor(input: inputWithoutPadding, offset: $0) }
        .reduce(into: [UInt8](), reduce)
    
    return Data(data)
}

private func reduce(into container: inout [UInt8], reductor: Reductor) throws {
    let buffer = try reductor.group.reduce(0) { buffer, offset in
        try reduce(into: buffer, offset: offset, input: reductor.input)
    }
    
    try container.append(contentsOf: reductor.convert(buffer))
}

private func reduce(into buffer: UInt64, offset: Int, input: String) throws -> UInt64 {
    let inputIndex = input.index(input.startIndex, offsetBy: offset)
    let alphabetIndex = alphabet.firstIndex(of: input[inputIndex])
    let valueOrNil = alphabetIndex.map { index in
        alphabet.distance(from: alphabet.startIndex, to: index)
    }
    
    guard let value = valueOrNil else {
        throw Base32DecodingError.invalidCharacter
    }
    
    let newBuffer = buffer << 5
    return newBuffer + UInt64(value)
}

private struct Reductor {
    var input: String
    var offset: Int
    
    var group: Range<Int> {
        offset..<maxOffset
    }
    
    func convert(_ buffer: UInt64) throws -> [UInt8] {
        var buffer = buffer
        if isLastGroup {
            buffer = buffer >> trailingBits
        }
        var result = [UInt8]()
        let bytesCount = try bytesCountInBuffer()
        for _ in 0..<bytesCount {
            result.append(UInt8(buffer & 0xFF))
            buffer = buffer >> 8
        }
        
        return result.reversed()
    }
    
    private var isLastGroup: Bool {
        nextOffset >= input.count
    }
    
    private var trailingBits: Int {
        ((maxOffset - offset) * bytesInGroup) % charactersInGroup
    }
    
    private func bytesCountInBuffer() throws -> Int {
        guard isLastGroup else {
            return bytesInGroup
        }
        
        switch input.count % charactersInGroup {
        case 0:
            return bytesInGroup
        case 2, 4, 5, 7:
            let partialGroupSize = Double(input.count % charactersInGroup)
            let leftoverBytes = floor(partialGroupSize * Double(bytesInGroup) / Double(charactersInGroup))
            return Int(leftoverBytes)
        default:
            throw Base32DecodingError.invalidInputSize
        }
    }
    
    private var nextOffset: Int {
        offset + charactersInGroup
    }
    
    private var maxOffset: Int {
        min(input.count, nextOffset)
    }
}

private let bytesInGroup = 5
private let charactersInGroup = 8
private let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"

public enum Base32DecodingError: Error {
    case invalidInputSize, invalidCharacter
}
