public struct Header {
    
    // Compatibility list available at https://github.com/RiotGames/LoRDeckCodes#process
    static private let maxSupported = [Header(format: 1, version: 5)]
    
    public var format: Int
    public var version: Int
    
    func isSupportedFormat() -> Bool {
        guard let supportedFormat = Header.maxSupported.first(where: {$0.format == format}) else {
            return false
        }
        
        return version <= supportedFormat.version
    }
}
