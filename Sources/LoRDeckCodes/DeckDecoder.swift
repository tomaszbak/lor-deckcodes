struct DeckDecoder {
    var input: [Int]
    
    func execute() throws -> Deck {
        guard !input.isEmpty else {
            throw DecodingError.emptyInput
        }
        
        let context = DecodingContext(step: .header)
        let result = try input.reduce(context, decode)
        return Deck(cards: result.cards)
    }
    
    private func decode(context: DecodingContext, value: Int) throws -> DecodingContext {
        switch context.step {
        case .header:
            return try parseHeader(value, with: context)
        case .numberOfSections:
            return try parseNumberOfSections(value, with: context)
        case .numberOfCardsInSection:
            return try parseNumberOfCardsInSection(value, with: context)
        case .set:
            return try parseSet(value, with: context)
        case .faction:
            return try parseFaction(value, with: context)
        case .card:
            return try parseCard(value, with: context)
        }
    }
    
    private func parseHeader(_ value: Int, with context: DecodingContext) throws -> DecodingContext {
        let format = (value & 0b11110000) >> 4
        let version = value & 0b00001111
        
        guard format == 1, version == 1 else {
            throw DecodingError.invalidFormat(Int(format), Int(version))
        }
        
        var context = context
        context.step = .numberOfSections
        return context
    }
    
    private func parseNumberOfSections(_ value: Int, with context: DecodingContext) throws -> DecodingContext {
        var context = context
        
        context.sectionsLeft = value
        
        if context.sectionsLeft > 0 {
            context.step = .numberOfCardsInSection
        } else {
            context.numberOfCards -= 1
            context.step = .numberOfSections
        }
        
        return context
    }
    
    private func parseNumberOfCardsInSection(_ value: Int, with context: DecodingContext) throws -> DecodingContext {
        var context = context
        
        context.cardsLeft = value
        context.step = .set
        
        return context
    }
    
    private func parseSet(_ value: Int, with context: DecodingContext) throws -> DecodingContext {
        var context = context
        
        context.set = Set(rawValue: value)
        context.step = .faction
        
        return context
    }
    
    private func parseFaction(_ value: Int, with context: DecodingContext) throws -> DecodingContext {
        var context = context
        
        context.faction = Faction(rawValue: value)
        context.step = .card
        
        return context
    }
    
    private func parseCard(_ value: Int, with context: DecodingContext) throws -> DecodingContext {
        var context = context
        guard let faction = context.faction else {
            throw DecodingError.invalidFaction
        }
        
        guard let set = context.set else {
            throw DecodingError.invalidFaction
        }
        
        let card = Card(set: set, faction: faction, identifier: value, numberOfCopies: context.numberOfCards)
        context.cards.append(card)
        
        context.cardsLeft -= 1
        
        if context.cardsLeft == 0 {
            context.sectionsLeft -= 1
            
            if context.sectionsLeft == 0 {
                context.numberOfCards -= 1
                context.step = .numberOfSections
            } else {
                context.step = .numberOfCardsInSection
            }
        }
        
        return context
    }
}

private enum Step {
    case header, numberOfSections, numberOfCardsInSection, set, faction, card
}

private struct DecodingContext {
    var step: Step
    var numberOfCards = 3
    var sectionsLeft = 0
    var cardsLeft = 0
    var set: Set?
    var faction: Faction?
    
    var cards: [Card] = []
}
