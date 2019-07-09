//
//  LastKnownFileType.swift
//  xcp
//
//  Created by kingkong999yhirose on 2016/12/23.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct LastKnownFile {
    let type: LastKnownFileType
    let value: String
    
    init(fileName: String) {
        guard let fileExtension = fileName.components(separatedBy: ".").last else {
            fatalError(assertionMessage(description: "unexpected fileExtension error"))
        }
        
        switch fileExtension {
        case "xib", "storyboard":
            self.type = .resourceFile
            self.value = "file.\(fileExtension)"
        case "h", "m":
            self.type = .sourceCode
            self.value = "sourcecode.\(fileExtension).objc"
        case "swift":
            self.type = .sourceCode
            self.value = "sourcecode.\(fileExtension)"
        case "md":
            self.type = .markdown
            self.value = "net.daringfireball.markdown"
        default:
            self.type = .text
            self.value = "text"
        }
    }
}

enum LastKnownFileType {
    case resourceFile
    case sourceCode
    case markdown
    case text
}
    
