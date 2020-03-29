public enum DecodingError: Error {
    case emptyInput
    case invalidFormat(Int, Int)
    case invalidFaction
    case invalidSet
}
