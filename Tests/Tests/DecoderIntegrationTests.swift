import XCTest
import Foundation
import LoRDeckCodes

final class DecoderIntegrationTests: XCTestCase {
    func testDecoderShouldValidateDeckCode() throws {
        // Ionia/Piltover & Zaun
        let code = "CEAAECABAQJRWHBIFU2DOOYIAEBAMCIMCINCILJZAICACBANE4VCYBABAILR2HRL"
        let jinxId = 40
        let cards = try Decoder().decode(code).cards
        
        XCTAssertEqual(cards.count, 24)
        XCTAssertEqual(cards.filter({ $0.numberOfCopies == 2 }).count, 16)
        XCTAssertEqual(cards.filter({ $0.numberOfCopies == 1 }).count, 8)
        XCTAssertEqual(cards.filter({ $0.faction == .ionia }).count, 12)
        XCTAssertEqual(cards.filter({ $0.faction == .piltoverAndZaun }).count, 12)
        XCTAssertTrue(cards.contains(where: { $0.identifier == jinxId}))
    }
    
    func testDecoderOnEmptyCodeShouldThrow() {
        XCTAssertThrowsError(try Decoder().decode(""))
    }
    
    func testDecoderOnInvalidCodeShouldThrow() {
        XCTAssertThrowsError(try Decoder().decode("INVALIDCODE"))
    }
}
