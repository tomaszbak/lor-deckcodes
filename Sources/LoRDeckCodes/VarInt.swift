import Foundation

func decodeVarInt(input: Data) -> [Int] {
    return input
        .reduce(into: Reductor()) { $0.append($1) }
        .result
}

private struct Reductor {
    private var buffer = 0
    private(set) var result = [Int]()
    
    private static let signMask: UInt8 = 0b10000000
    private static let valueMask: UInt8 = ~signMask
    
    mutating func append(_ value: UInt8) {
        buffer += Int(value & Reductor.valueMask)
        let hasNextByte = Reductor.signMask & value > 0
        if hasNextByte {
            buffer <<= 7
        } else {
            flush()
        }
    }
    
    private mutating func flush() {
        result.append(buffer)
        buffer = 0
    }
}
