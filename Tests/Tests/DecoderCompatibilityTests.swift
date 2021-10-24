import XCTest
import Foundation
import LoRDeckCodes

final class DecoderTests: XCTestCase {
    func testDecoderWithTestData() throws {
        let decks = try prepareTestData()
        
        print("Running tests for \(decks.count) deck codes")
        let sut = Decoder()
        for deck in decks {
            Assert(sut, with: deck)
        }
    }
    
    private func prepareTestData() throws -> [TestDeck] {
        guard let url = Bundle.module.url(forResource: "test-data", withExtension: "txt", subdirectory: "Resources") else {
            throw TestDataError.dataMissing
        }
        let text = try String(contentsOf: url)
        return try text
            .components(separatedBy: "\n\n")
            .map { $0.split(whereSeparator: \.isNewline).map(String.init) }
            .map(TestDeck.init)
    }
}

private extension TestDeck {
    init(_ array: [String]) throws {
        guard let code = array.first else {
            throw TestDataError.codeMissing
        }
        
        let cards = Set(array.dropFirst())
        self.init(deckCode: code, cardCodes: cards)
    }
}

private enum TestDataError: Error {
    case dataMissing, codeMissing
}
