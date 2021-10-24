import XCTest
import Foundation
import LoRDeckCodes

final class DecoderIntegrationTests: XCTestCase {
    func testDecoderOnEmptyCodeShouldThrow() {
        XCTAssertThrowsError(try Decoder().decode(""))
    }
    
    func testDecoderOnInvalidCodeShouldThrow() {
        XCTAssertThrowsError(try Decoder().decode("INVALIDCODE"))
    }
    
    func testDecoderShouldValidateFoundationDeckCode() throws {
        Assert(Decoder(), with: .jinxAndZed)
    }
    
    func testDecoderShouldValidateBilgewaterDeckCode() throws {
        Assert(Decoder(), with: .fizzAndLux)
    }
    
    func testDecoderShouldValidateTargonDeckCode() throws {
        Assert(Decoder(), with: .trundleAndAurelionSol)
    }
    
    func testDecoderShouldValidateShurimaDeckCode() throws {
        Assert(Decoder(), with: .akshanAndSivir)
    }
    
    func testDecoderShouldValidateBandleCityDeckCode() throws {
        Assert(Decoder(), with: .ziggsAndPoppy)
    }
}
