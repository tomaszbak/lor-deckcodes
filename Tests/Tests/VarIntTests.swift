import XCTest
import Foundation
@testable import LoRDeckCodes

final class VarIntTests: XCTestCase {
    func testDecodeVarIntWhenOneByteShouldReturnExpected() throws {
        XCTAssertEqual(decodeVarInt(input: Data([42])), [42])
    }
    
    func testDecodeVarIntWhenTwoNonContinuousBytesShouldReturnExpected() throws {
        XCTAssertEqual(decodeVarInt(input: Data([42, 43])), [42, 43])
    }
    
    func testDecodeVarIntWhenTwoBytesForOneIntShouldReturnExpected() throws {
        XCTAssertEqual(decodeVarInt(input: Data([138, 1])), [138])
    }
    
    func testDecodeVarIntWhenThreeBytesForOneIntShouldReturnExpected() throws {
        XCTAssertEqual(decodeVarInt(input: Data([128, 128, 1])), [16384])
    }
}
