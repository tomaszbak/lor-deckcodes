import XCTest
import Foundation
@testable import LoRDeckCodes

final class CardTests: XCTestCase {
    func testDescriptionShouldHaveExpectedFormat() {
        let xolaani = Card(
            set: .worldwalker,
            faction: .targon,
            identifier: 35,
            numberOfCopies: 1
        )
        
        XCTAssertEqual(xolaani.description, "1:06MT035")
    }
}
