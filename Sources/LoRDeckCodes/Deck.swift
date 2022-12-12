public struct Deck {
    public var cards: [Card]
}

public struct Card: Equatable {
    public var set: Set
    public var faction: Faction
    public var identifier: Int
    public var numberOfCopies: Int
    
    public var code: String {
        String(
            format: "%02d%@%03d",
            set.rawValue,
            faction.description,
            identifier
        )
    }
    
    public static func ==(rhs: Card, lhs:Card) -> Bool {
        return rhs.code == lhs.code
    }
}

extension Card: CustomStringConvertible {
    public var description: String {
        "\(numberOfCopies):\(code)"
    }
}
