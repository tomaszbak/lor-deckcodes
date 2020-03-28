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
        XCTAssertEqual(decodeVarInt(input: Data([170, 43])), [5419])
    }
}
