import Foundation

public struct Decoder {
    public init() { }
    
    public func decode(_ code: String) throws -> Deck {
        let data = try decodeBase32(code)
        let values = decodeVarInt(input: data)
        return try DeckDecoder(input: values).execute()
    }
}
