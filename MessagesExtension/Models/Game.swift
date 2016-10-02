//
//  Game.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-17.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import Foundation
import Messages

let GamePickQueryItemKey:String = "Pick"
let GameSenderQueryItemKey:String = "Sender"

struct Game {
    var picks: [Pick]
    var sender: String?
}

extension Game {
    // Initializer for a new game
    init?(numPicks: Int) {
        if numPicks == 0 {
            return nil
        }
        
        let maxRange: Int = numPicks - 1
//        let chosenPickIndex: Int = Int(arc4random_uniform(UInt32(maxRange)))
        let chosenPickIndex: Int = 0;
        
        self.picks = [Pick]()
        for index in 0...numPicks {
            let pick:Pick = Pick(isUnlucky: index == chosenPickIndex, isPicked: false)
            self.picks.append(pick)
        }        
    }
    
    func isOver() -> Bool {
        for pick in picks {
            if pick.isPicked && pick.isUnlucky {
                return true
            }
        }
        
        return false
    }
}

extension Game {
    // this is an initializer used when parsing received message
    init?(queryItems: [URLQueryItem]) {        
        self.picks = [Pick]()
        for queryItem in queryItems {
            guard let value = queryItem.value else { continue }
            
            if queryItem.name == GamePickQueryItemKey {
                let decordedPick: Pick = Pick(rawValue: value)
                self.picks.append(decordedPick)
                
            } else if queryItem.name == GameSenderQueryItemKey {
                self.sender = value
            }
        }        
    }
    
    // this is sent in the message from delegate in MainGameViewController
    var queryItems: [URLQueryItem] {
        var items = [URLQueryItem]()
        
        // attach all picks
        for pick in self.picks {
            items.append(pick.queryItem)
        }
        
        // attach the sender
        let uuid:String = UIDevice.current.identifierForVendor!.uuidString
        items.append(URLQueryItem(name: GameSenderQueryItemKey, value: uuid))

        return items
    }
}

extension Game {
    init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        self.init(queryItems: queryItems)
    }
}
   
