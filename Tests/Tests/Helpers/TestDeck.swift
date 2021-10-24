struct TestDeck {
    var deckCode: String
    var cardCodes: Set<String>
}

extension TestDeck {
    init(@Builder build: () -> TestDeck) {
        self = build()
    }
    
    @resultBuilder struct Builder {
        static func buildBlock(_ deckCode: String, _ cardCodes: String...) -> TestDeck {
            TestDeck(deckCode: deckCode, cardCodes: Set(cardCodes))
        }
    }
}
