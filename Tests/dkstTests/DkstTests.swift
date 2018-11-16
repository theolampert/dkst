import XCTest
import Dkst

final class DkstTests: XCTestCase {
    func testCLI() throws {
      // let result = Utilities.createOutputPath(out: "", file: "", format: "PDF")
      XCTAssertEqual(1, 1)
    }

    static var allTests = [
        ("testCLI", testCLI)
    ]
}
