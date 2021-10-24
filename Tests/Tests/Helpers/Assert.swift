import XCTest
import LoRDeckCodes

func Assert(_ decoder: Decoder, with deck: TestDeck, file: StaticString = #file, line: UInt = #line) {
    do {
        let result = try decoder.decode(deck.deckCode).cards.map(\.description)
        XCTAssertEqual(Set(result), deck.cardCodes, file: file, line: line)
    } catch {
        XCTFail("Deck code \(deck.deckCode) decoding failed with error: \(error)", file: file, line: line)
    }
}
