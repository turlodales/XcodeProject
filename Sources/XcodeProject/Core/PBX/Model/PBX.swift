//
//  swift
//  xcp
//
//  Created by kingkong999yhirose on 2016/09/20.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

// MARK: - Name space
public enum /* prefix */ PBX { }

extension /* prefix */ PBX {
    open class Project: Object {
        open var developmentRegion: String  { return self.extractString(for: "developmentRegion") }
        open var hasScannedForEncodings: Bool { return self.extractBool(for: "hasScannedForEncodings") }
        open var knownRegions: [String] { return self.extractStrings(for: "knownRegions") }
        open var targets: [PBX.NativeTarget] { return self.extractObjects(for: "targets") }
        open var mainGroup: PBX.Group { return self.extractObject(for: "mainGroup") }
        open var buildConfigurationList: XC.ConfigurationList { return self.extractObject(for: "buildConfigurationList") }
        open var attributes: PBXRawMapType { return self.extractPair(for: "attributes") }
    }
    
    open class ContainerItemProxy: ContainerItem {
        
    }
    
    open class BuildFile: ProjectItem {
        open var fileRef: PBX.Reference { return self.extractObject(for: "fileRef") }
    }
    
    open class CopyFilesBuildPhase: PBX.BuildPhase {
        open var name: String? { return self.extractStringIfExists(for: "name") }
    }
    
    open class FrameworksBuildPhase: PBX.BuildPhase {
        
    }
    
    open class HeadersBuildPhase: PBX.BuildPhase {
        
    }
    
    open class ResourcesBuildPhase: PBX.BuildPhase {
        override open var objectDictionary: PBXRawMapType {
            return [
                "isa": isa.rawValue,
                "buildActionMask": Int32.max,
                "files": files.map { $0.id },
                "runOnlyForDeploymentPostprocessing": 0
            ]
        }
    }
    
    open class ShellScriptBuildPhase: PBX.BuildPhase {
        open var name: String? { return self.extractStringIfExists(for: "name") }
        open var shellScript: String { return self.extractString(for: "shellScript") }
    }
    
    open class SourcesBuildPhase: PBX.BuildPhase {
        override open var objectDictionary: PBXRawMapType {
            return PBXSourcesBuildPhaseTranslator().toPair(for: self)
        }
    }
    
    open class BuildStyle: ProjectItem {
        
    }
    
    open class AggregateTarget: Target {
        
    }
    
    open class NativeTarget: Target {
        
    }
    
    open class TargetDependency: ProjectItem {
        
    }
    
    open class Reference: ContainerItem {
        open var name: String? { return self.extractStringIfExists(for: "name") }
        open var path: String? { return self.extractStringIfExists(for: "path") }
        open var sourceTree: SourceTreeType { return SourceTreeType(for: self.extractString(for: "sourceTree")) }
    }
    
    open class ReferenceProxy: Reference {
        // convenience accessor
        open var remoteRef: ContainerItemProxy { return self.extractObject(for: "remoteRef") }
    }
    
    open class FileReference: Reference {
        // convenience accessor
        open var fullPath: PathComponent {
            return self.generateFullPath()
        }
        
        fileprivate func generateFullPath() -> PathComponent {
            guard let path = allPBX.fullFilePaths[self.id] else {
                fatalError(assertionMessage(description:
                    "unexpected id: \(id)",
                    "and fullFilePaths: \(allPBX.fullFilePaths)"
                    )
                )
            }
            return path
        }
    }
    
    open class Group: Reference {
        override open var objectDictionary: PBXRawMapType {
            var pair: PBXRawMapType = [
                "isa": isa.rawValue,
                "children": children.map { $0.id },
                "sourceTree": sourceTree.value
            ]
            if let name = name  {
                pair["name"] = name
            }
            if let path = path {
                pair["path"] = path
            }
            return pair
        }
        
        open lazy var children: [Reference] = self.extractObjects(for: "children")
        open var fullPath: String = ""
        
        // convenience accessor
        open var subGroups: [Group] { return self.makeSubGroups() }
        open var fileRefs: [PBX.FileReference] { return self.makeFileRefs() }
        
        func makeSubGroups() -> [Group] {
            return self.children.ofType(PBX.Group.self)
        }
        
        func makeFileRefs() -> [PBX.FileReference] {
            return self.children.ofType(PBX.FileReference.self)
        }
    }
    
    open class VariantGroup: PBX.Group {
        
    }
    
}
