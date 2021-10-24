import XCTest
import Foundation
@testable import LoRDeckCodes

final class CardTests: XCTestCase {
    func testDescriptionShouldHaveExpectedFormat() {
        let hecarim = Card(
            set: .foundations,
            faction: .shadowIsles,
            identifier: 42,
            numberOfCopies: 2
        )
        
        XCTAssertEqual(hecarim.description, "2:01SI042")
    }
}
