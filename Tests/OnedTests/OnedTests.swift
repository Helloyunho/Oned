import XCTest
import class Foundation.Bundle

final class OnedTests: XCTestCase {
    func testHelloWorld() throws {
        guard #available(macOS 10.13, *) else {
            return
        }

        #if !targetEnvironment(macCatalyst)

        let fooBinary = productsDirectory.appendingPathComponent("Oned")

        let process = Process()
        process.executableURL = fooBinary

        let outPipe = Pipe()
        process.standardOutput = outPipe
        
        let inPipe = Pipe()
        process.standardInput = inPipe

        try process.run()
        try inPipe.fileHandleForWriting.write(
            contentsOf: "console.log('Hello, World!');exit();\n".data(using: .utf8)!
        )

        process.waitUntilExit()

        let data = outPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, "> Hello, World!\n")
        #endif
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
}
