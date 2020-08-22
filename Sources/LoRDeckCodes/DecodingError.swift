public enum DecodingError: Error {
    case emptyInput
    case unsupportedFormat(Header)
    case missingSet
    case missingFaction
    case invalidSet(Int)
    case invalidFaction(Int)
}
