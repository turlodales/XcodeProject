//
//  SubscriptionTests.swift
//  XcodeProjectCoreTests
//
//  Created by Yudai Hirose on 2019/07/26.
//

import XCTest
@testable import XcodeProjectCore

class SubscriptionTests: XCTestCase {
    
    func testSubscriptions() {
        XCTContext.runActivity(named: "For PBX.Object [id:]", block: { _ in
            XCTContext.runActivity(named: "When abstract class", block: { _ in
                XCTContext.runActivity(named: "And it is not exists", block: { _ in
                    let project = makeXcodeProject()
                    let object = project.context.objects.values[id: ""]
                    XCTAssertNil(object)
                })
                XCTContext.runActivity(named: "And it exists", block: { _ in
                    let project = makeXcodeProject()
                    let object = project.context.objects.values[id: "33467EB922E6C5B700897582"]
                    XCTAssertNotNil(object)
                })
            })
            XCTContext.runActivity(named: "When subclass", block: { _ in
                XCTContext.runActivity(named: "And it is not exists", block: { _ in
                    let project = makeXcodeProject()
                    let object = project.fileRefs[id: ""]
                    XCTAssertNil(object)
                })
                XCTContext.runActivity(named: "And it exists", block: { _ in
                    let project = makeXcodeProject()
                    let object = project.fileRefs[id: "33467EB922E6C5B700897582"]
                    XCTAssertNotNil(object)
                })
            })
        })
        XCTContext.runActivity(named: "For PBX.Reference [name:]", block: { _ in
            let project = makeXcodeProject()
            let object = project.fileRefs[path: "AppDelegate.swift"]
            XCTAssertNotNil(object)
        })
        XCTContext.runActivity(named: "For PBX.Target [name:]", block: { _ in
            let project = makeXcodeProject()
            let object = project.targets[name: "iOSTestProject"]
            XCTAssertNotNil(object)
        })
        XCTContext.runActivity(named: "For PBX.BuildPhase [fileName:]", block: { _ in
            let project = makeXcodeProject()
            let object = project.buildPhases[fileName: "AppDelegate.swift"]
            XCTAssertNotNil(object)
        })
        XCTContext.runActivity(named: "For PBX.BuildFile [fileName:]", block: { _ in
            let project = makeXcodeProject()
            let object = project.buildFiles[fileName: "AppDelegate.swift"]
            XCTAssertNotNil(object)
        })
        XCTContext.runActivity(named: "For PBX.Group [fullPath:]", block: { _ in
            let project = makeXcodeProject()
            let object = project.groups[fullPath: "iOSTestProject/Group"]
            XCTAssertNotNil(object)
        })
    }
}
