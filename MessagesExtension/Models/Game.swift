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
    var picks: [Pick]
    
    var isOver: Bool?
}

extension Game {
    init?(numPicks: Int) {
        if numPicks == 0 {
            return nil
        }
        
        let maxRange: Int = numPicks - 1
        let chosenPickIndex: Int = Int(arc4random_uniform(UInt32(maxRange)))
        
        self.picks = [Pick]()
        for index in 0...numPicks {
            let pick:Pick = Pick(isUnlucky: index == chosenPickIndex, isPicked: false)
            self.picks.append(pick)
        }
        
        self.isOver = false
    }
}

extension Game {
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        for pick in self.picks {
            items.append(pick.queryItem)
        }

        return items
    }
    
    init?(queryItems: [URLQueryItem]) {        
        self.picks = [Pick]()
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            
            if queryItem.name == "Pick" {
                let decordedPick: Pick = Pick(rawValue: value)
                self.picks.append(decordedPick)
            }
        }        
    }
}

extension Game {
    init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        self.init(queryItems: queryItems)
    }
}
   
