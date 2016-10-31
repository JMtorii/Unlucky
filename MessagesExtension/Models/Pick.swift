//
//  Picks.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-17.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit

struct Pick {    
    var isUnlucky: Bool!
    
    var isPicked: Bool!
    
    init(isUnlucky: Bool, isPicked: Bool) {
        self.isUnlucky = isUnlucky
        self.isPicked = isPicked
    }
    
    init(rawValue: String) {
        // we assume rawValue keys are isUnlucky and isPicked and nothing else
        let data: NSData = rawValue.data(using: String.Encoding.utf8)! as NSData
                
        do {
            let anyObj: Any? = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
            self.parseJson(anyObj: anyObj!)
            
        } catch {
            print(error)
        }        
    }
    
    private mutating func parseJson(anyObj: Any) {
        let obj = anyObj as? [String:AnyObject]
        
        guard let isUnluckyDecoded: String = (obj?["isUnlucky"] as? String) else {
            fatalError("Bad message data")
        }
        
        self.isUnlucky = Bool(isUnluckyDecoded)
        
        guard let isPickedDecoded: String = (obj?["isPicked"] as? String) else {
            fatalError("Bad message data")
        }
        self.isPicked = Bool(isPickedDecoded)      
    }
    
    func rawValue() -> String {
        return "{\"isUnlucky\": \"\(String(self.isUnlucky))\", \"isPicked\": \"\(String(self.isPicked))\" }"
    }
}

extension Pick: QueryItemRepresentable {
    var queryItem: URLQueryItem {
        return URLQueryItem(name: self.queryItemKey, value: rawValue())
    }
    
    var queryItemKey: String {
        return GamePickQueryItemKey
    }
}
