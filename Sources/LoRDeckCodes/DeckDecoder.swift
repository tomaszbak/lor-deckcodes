struct DeckDecoder {
    var input: [Int]
    
    func execute() throws -> Deck {
        guard !input.isEmpty else {
            throw DecodingError.emptyInput
        }
        
        let result = try input.reduce(HeaderStep()) { step, value -> Step in
            var step = step
            return try step.evaluate(value)
        }
        return Deck(cards: result.context.cards)
    }
}

private struct DecodingContext {
    var numberOfCards = 3
    var sectionsLeft = 0
    var cardsLeft = 0
    var set: Set?
    var faction: Faction?
    
    var cards: [Card] = []
}

private protocol Step {
    var context: DecodingContext { get }
    mutating func evaluate(_ value: Int) throws -> Step
}

private struct HeaderStep: Step {
    var context = DecodingContext()
    
    func evaluate(_ value: Int) throws -> Step {
        let header = Header(
            format: (value & 0b11110000) >> 4,
            version: value & 0b00001111
        )
        
        guard header.isSupportedFormat() else {
            throw DecodingError.unsupportedFormat(header)
        }

        return NumberOfSectionsStep(context: context)
    }
    
}

private struct NumberOfSectionsStep: Step {
    var context: DecodingContext
    
    mutating func evaluate(_ value: Int) throws -> Step {
        context.sectionsLeft = value
        
        if context.sectionsLeft > 0 {
            return NumberOfCardsInSectionStep(context: context)
        } else {
            context.numberOfCards -= 1
            return NumberOfSectionsStep(context: context)
        }
    }
}

private struct NumberOfCardsInSectionStep: Step {
    var context: DecodingContext
    
    mutating func evaluate(_ value: Int) throws -> Step {
        context.cardsLeft = value
        return SetStep(context: context)
    }
}

private struct SetStep: Step {
    var context: DecodingContext
    
    mutating func evaluate(_ value: Int) throws -> Step {
        guard let set = Set(rawValue: value) else {
            throw DecodingError.invalidSet(value)
        }
        context.set = set
        
        return FactionStep(context: context)
    }
}

private struct FactionStep: Step {
    var context: DecodingContext
    
    mutating func evaluate(_ value: Int) throws -> Step {
        guard let faction = Faction(rawValue: value) else {
            throw DecodingError.invalidFaction(value)
        }
        
        context.faction = faction
        return CardStep(context: context)
    }
}

private struct CardStep: Step {
    var context: DecodingContext
    
    mutating func evaluate(_ value: Int) throws -> Step {
        guard let faction = context.faction else {
            throw DecodingError.missingFaction
        }
        
        guard let set = context.set else {
            throw DecodingError.missingSet
        }
        
        let card = Card(set: set, faction: faction, identifier: value, numberOfCopies: context.numberOfCards)
        context.cards.append(card)
        context.cardsLeft -= 1
        
        guard context.cardsLeft == 0 else {
            return CardStep(context: context)
        }
        
        context.sectionsLeft -= 1
        
        guard context.sectionsLeft == 0 else {
            return NumberOfCardsInSectionStep(context: context)
        }
        
        context.numberOfCards -= 1
        return NumberOfSectionsStep(context: context)
    }
}
