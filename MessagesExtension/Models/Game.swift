//
//  Game.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-17.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import Foundation
import Messages

struct Game {
    var rawValue: String?
    
    var picks: [Pick]
}

extension Game {
    init?(numPicks: Int) {
        if numPicks == 0 {
            return nil
        }
        
        let maxRange: Int = numPicks - 1
        let chosenPickIndex: Int = Int(arc4random_uniform(UInt32(maxRange)))
        
        picks = [Pick]()
        for index in 0...numPicks {
            let pick:Pick = Pick(isUnlucky: index == chosenPickIndex)
            picks.append(pick)
        }
    }
}

extension Game {
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
//        if let part = base {
//            items.append(part.queryItem)
//        }
//        if let part = scoops {
//            items.append(part.queryItem)
//        }
//        if let part = topping {
//            items.append(part.queryItem)
//        }
        
        return items
    }
    
//    init?(queryItems: [URLQueryItem]) {
//        var base: Base?
//        var scoops: Scoops?
//        var topping: Topping?
//        
//        for queryItem in queryItems {
//            guard let value = queryItem.value else { continue }
//            
//            if let decodedPart = Base(rawValue: value), queryItem.name == Base.queryItemKey {
//                base = decodedPart
//            }
//            if let decodedPart = Scoops(rawValue: value), queryItem.name == Scoops.queryItemKey {
//                scoops = decodedPart
//            }
//            if let decodedPart = Topping(rawValue: value), queryItem.name == Topping.queryItemKey {
//                topping = decodedPart
//            }
//        }
        
//        var game: Game?
//        
//        for queryItem in queryItems {
//            guard let value = queryItem.value else { continue }
//            
//        }
//        
//        
//        guard let decodedBase = base else { return nil }
//        
//        self.base = decodedBase
//        self.scoops = scoops
//        self.topping = topping
//    }
}

extension Game {
    init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        picks = [Pick]()
//        self.init(queryItems: queryItems)
    }
}
   
