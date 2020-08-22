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
    
    func testDecoderShouldValidateBilgeWaterDeckCode() throws {
        // Demacia/Bilgewater
        let code = "CEBQOAQGBAFQ4HA5FY6QEAQAAEEQGAIAB4QSUAIBAEABUAQBAEADEAICAACQ"
        let fizzId = 46
        let cards = try Decoder().decode(code).cards
        
        XCTAssertEqual(cards.count, 15)
        XCTAssertEqual(cards.filter({ $0.numberOfCopies == 2 }).count, 1)
        XCTAssertEqual(cards.filter({ $0.numberOfCopies == 1 }).count, 2)
        XCTAssertEqual(cards.filter({ $0.faction == .bilgewater }).count, 7)
        XCTAssertEqual(cards.filter({ $0.faction == .demacia }).count, 8)
        XCTAssertTrue(cards.contains(where: { $0.identifier == fizzId}))
    }
    
    func testDecoderOnEmptyCodeShouldThrow() {
        XCTAssertThrowsError(try Decoder().decode(""))
    }
    
    func testDecoderOnInvalidCodeShouldThrow() {
        XCTAssertThrowsError(try Decoder().decode("INVALIDCODE"))
    }
}
