import XCTest
import DkstLib

final class DkstTests: XCTestCase {
    func testCreateOutputPath() throws {
      let result = Utilities.createOutputPath(out: "/foo", file: "/bar.md", format: "PDF")
      XCTAssertEqual(result, "/foo/bar.PDF")
    }

    static var allTests = [
        ("testCreateOutputPath", testCreateOutputPath)
    ]
}
