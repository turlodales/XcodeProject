//
//  FieldFormatter.swift
//  Swdifft
//
//  Created by Yudai Hirose on 2019/07/22.
//

import Foundation

public typealias FieldFormatterInfomation = (key: PBXRawKeyType, value: PBXRawAnyValueType, isa: ObjectType)
public protocol FieldFormatter: AutoMockable {
    func format(context: Context, of info: FieldFormatterInfomation, for level: Int) -> String
}

public struct FieldListFormatterImpl: SerializeFormatter, FieldFormatter {

    private let atomicValueFormatter: PBXAtomicValueFormatter
    private let valueListFormatter: PBXAtomicValueListFieldFormatter
    private let mapFormatter: PBXRawMapFormatter
    private let mapListFormatter: PBXRawMapListFormatter
    public init(
        atomicValueFormatter: PBXAtomicValueFormatter = PBXAtomicValueFormatterImpl(),
        valueListFormatter: PBXAtomicValueListFieldFormatter = PBXAtomicValueListFieldFormatterImpl(),
        mapFormatter: PBXRawMapFormatter = PBXRawMapFormatterImpl(),
        mapListFormatter: PBXRawMapListFormatter = PBXRawMapListFormatterImpl()
        ) {
        self.atomicValueFormatter = atomicValueFormatter
        self.valueListFormatter = valueListFormatter
        self.mapFormatter = mapFormatter
        self.mapListFormatter = mapListFormatter
    }
    public func format(context: Context, of info: FieldFormatterInfomation, for level: Int) -> String {
        let key = try! escape(with: info.key)
        let object = info.value
        
        if key == "isa" {
            fatalError("unexcepct isa: \(info.isa)")
        }
        
        switch object {
        case let objectIds as [String]:
            return valueListFormatter.format(context: context, of: (key: key, value: objectIds, isa: info.isa), for: level)
        case let mapList as [PBXRawMapType]:
            return mapListFormatter.format(context: context, of: (key: key, value: mapList, isa: info.isa), in: level, next: self)
        case let map as PBXRawMapType:
            return mapFormatter.format(context: context, of: (key: key, value: map, isa: info.isa), in: level, next: self)
        case let value as Int:
            return atomicValueFormatter.format(context: context, of: (key: key, value: value, isa: info.isa), in: level)
        case let value as Int32:
            return atomicValueFormatter.format(context: context, of: (key: key, value: value, isa: info.isa), in: level)
        case let value as String:
            return atomicValueFormatter.format(context: context, of: (key: key, value: value, isa: info.isa), in: level)
        case _:
            fatalError("Unexpected type: \(info)")
        }
    }
}

