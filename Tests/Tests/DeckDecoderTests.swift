import XCTest
@testable import LoRDeckCodes

final class DeckDecoderTests: XCTestCase {
    func testDecoderWhenEmptyInputShouldThrow() {
        XCTAssertThrowsError(try DeckDecoder(input: []).execute())
    }
    
    func testDecoderWhenValidFormatShouldParse() throws {
        let input = [0b00010001, 0]
        let result = try DeckDecoder(input: input).execute()
        XCTAssertEqual(result.cards, [])
    }
    
    func testDecoderWhenInvalidFormatShouldThrow() {
        let input = [0b01110001, 0]
        XCTAssertThrowsError(try DeckDecoder(input: input).execute())
    }
    
    func testDecoderWhenInvalidVersionShouldThrow() {
        let input = [0b00010111, 0]
        XCTAssertThrowsError(try DeckDecoder(input: input).execute())
    }
    
    func testDecoderShouldDecodeOnCard() throws {
        let input = [17, 1, 1, 1, 2, 10]
        let result = try DeckDecoder(input: input).execute()
        let expected = Card(set: .foundations, faction: .ionia, identifier: 10, numberOfCopies: 3)
        XCTAssertEqual(result.cards, [expected])
    }
    
    func testDecoderShouldDecodeTwoCards() throws {
        let input = [17, 0, 1, 2, 1, 4, 42, 44]
        let result = try DeckDecoder(input: input).execute()
        let expected = [
            Card(set: .foundations, faction: .piltoverAndZaun, identifier: 42, numberOfCopies: 2),
            Card(set: .foundations, faction: .piltoverAndZaun, identifier: 44, numberOfCopies: 2),
        ]
        XCTAssertEqual(result.cards, expected)
    }
}
