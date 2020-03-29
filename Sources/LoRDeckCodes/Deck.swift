public struct Deck {
    public var cards: [Card]
}

public struct Card: Equatable, CustomStringConvertible {
    public var set: Set
    public var faction: Faction
    public var identifier: Int
    public var numberOfCopies: Int
    
    public var description: String {
        String(format: "%02d%@%03d x%d", set.rawValue, "\(faction)", identifier, numberOfCopies)
    }
}
