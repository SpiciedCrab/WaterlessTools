//
//  LeanCloudObjectable.swift
//  Waterless
//
//  Created by Harly on 2017/7/17.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import LeanCloud

// MARK: - Object extension for Properties
extension NSObject
{
    /// View all properties and do sth
    ///
    /// - Parameter keyAction: key action for each property
    /// - Returns: is action succeedded
    static func literateObject(keyAction : (String) -> Bool) -> Bool?
    {
        guard let allProperties = self.allProperty() as? [String] else {
            return nil
        }
        
        var isValueSet = false
        
        for propertyName in allProperties
        {
            if !isValueSet
            {
                isValueSet = keyAction(propertyName)
            }
        }
        
        return isValueSet
    }
}

// MARK: - LeanCloud Adapter
/// LeanCloud Adapter
protocol LeanCloudObjectable
{
    
    /// Transfer LCObject to normal Obj
    ///
    /// - Parameter query: LCObject
    /// - Returns: normalObj
    func normalObject<Element : NSObject>(from query : LCObject) -> Element?
    
    /// Transfer normal Obj to LCObject
    ///
    /// - Parameters:
    ///   - object: Parameter object: normal obj
    ///   - lCName: Class name
    ///   - objectId: objId
    /// - Returns: LCObject
    func lcObject<Element : NSObject>(from object : Element , on lCName : String , with objectId : String?) -> LCObject?
}

extension LeanCloudObjectable
{
    func normalObject<Element: NSObject>(from query : LCObject) -> Element?
    {
        let result = Element()
        
        let isValid = Element.literateObject { (propertyName) -> Bool in
            guard let lcValue = query.get(propertyName) else { return false }
            guard let stringValue = lcValue.stringValue else { return false }
            result.setValue(stringValue, forKey: propertyName)
            return true
        }
        
        guard let realValid = isValid , realValid else { return nil }
        
        return realValid ? result : nil
    }
    
    func lcObject<Element : NSObject>(from object : Element , on lCName : String , with objectId : String? = nil) -> LCObject?
    {
        let resultObject = objectId == nil ? LCObject(className: lCName) : LCObject(className: lCName, objectId: objectId!)
        
        let isValid = Element.literateObject { (propertyName) -> Bool in
            guard let objValue = object.value(forKey: propertyName) as? LCValueConvertible else { return false }
            resultObject.set(propertyName, value: objValue)
            return true
        }
        
        guard let realValid = isValid , realValid else { return nil }
        
        return realValid ? resultObject : nil
    }
}
