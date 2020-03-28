import XCTest
@testable import LoRDeckCodes

final class Base32Tests: XCTestCase {
    func testDecodeBase32WhenOneGroupShouldReturnExpected() throws {
        let expected = "ABCDE".data(using: .ascii)
        XCTAssertEqual(try decodeBase32("IFBEGRCF"), expected)
    }
    
    func testDecodeBase32WhenPaddingShouldReturnExpected() throws {
        let expected = "AB".data(using: .ascii)
        XCTAssertEqual(try decodeBase32("IFBA===="), expected)
    }
    
    func testDecodeBase32WhenMultipleGroupsShouldReturnExpected() throws {
        let expected = "foobar".data(using: .ascii)
        XCTAssertEqual(try decodeBase32("MZXW6YTBOI======"), expected)
    }
}
