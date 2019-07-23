import XCTest
@testable import XcodeProject

func isDirectory(_ dirName: String) -> Bool {
    let fileManager = FileManager.default
    var isDir: ObjCBool = false
    if fileManager.fileExists(atPath: dirName, isDirectory: &isDir) {
        if isDir.boolValue {
            return true
        }
    }
    return false
}


class XcodeProjectTests: XCTestCase {
    func testExistsGroup() {
        XCTContext.runActivity(named: "When is exists group", block:  { _ in
            XCTContext.runActivity(named: "It is flatten", block: { _ in
                let xcodeproject = makeXcodeProject()
                XCTAssertNotNil(
                    xcodeproject.group(for: "iOSTestProject")
                )
            })
            XCTContext.runActivity(named: "It is nested", block: { _ in
                let xcodeproject = makeXcodeProject()
                XCTAssertNotNil(
                    xcodeproject.group(for: "iOSTestProject/Group")
                )
            })
        })
        XCTContext.runActivity(named: "When is not exists group", block:  { _ in
            XCTContext.runActivity(named: "It is flatten", block: { _ in
                let xcodeproject = makeXcodeProject()
                XCTAssertNil(
                    xcodeproject.group(for: "Hoge")
                )
            })
            XCTContext.runActivity(named: "It is nested", block: { _ in
                let xcodeproject = makeXcodeProject()
                XCTAssertNil(
                    xcodeproject.group(for: "Hoge/Fuga")
                )
            })
        })
    }
}
