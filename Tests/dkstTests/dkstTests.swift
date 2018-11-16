import XCTest
import class Foundation.Bundle

final class DkstTests: XCTestCase {
    func testCLI() throws {
      XCTAssertEqual(1, 1)
    }
    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testCLI", testCLI)
    ]
}
