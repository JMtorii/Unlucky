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

class Game {
    var picks: [Pick]
    var sender: String?
    

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
    
    // this is an initializer used when parsing received message
    init(queryItems: [URLQueryItem]) {        
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
    
    init?(rawPicks: [String], sender: String) {        
        self.picks = [Pick]()
        for rawPick in rawPicks {
            self.picks.append(Pick(rawValue: rawPick))
        }
        
        self.sender = sender 
    }
    
    // For some reason, I can't save this object into NSUserDefaults
//    required init?(coder aDecoder: NSCoder) {
//        guard let rawPicks = aDecoder.decodeObject(forKey: "picks") as? [String], let sender = aDecoder.decodeObject(forKey: "sender") as? String else { 
//            return nil 
//        }
//        
//        self.picks = [Pick]()
//        for rawPick in rawPicks {
//            self.picks.append(Pick(rawValue: rawPick))
//        }
//        
//        self.sender = sender        
//    }
    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.generateRawPicks() as NSArray, forKey: "picks")
//        aCoder.encode(self.sender, forKey: "sender")
//    }
    
    func isOver() -> Bool {
        for pick in self.picks {
            if pick.isPicked && pick.isUnlucky {
                return true
            }
        }
        
        return false
    }
    
    func isFirstMove() -> Bool {
        var onePicked: Bool = false
        for pick in self.picks {
            if pick.isPicked! {
                if onePicked {
                    return false
                } else {
                    onePicked = true
                }
            }
        }
        
        return onePicked
    }
    
    private func generateRawPicks() -> [String] {
        var rawPicks: [String] = []
        
        for pick in self.picks {
            rawPicks.append(pick.rawValue())
        }
        
        return rawPicks
    }
}

extension Game {    
    // this is sent in the message from delegate in MainGameViewController
    func queryItems(uuid: String) -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        // attach all picks
        for pick in self.picks {
            items.append(pick.queryItem)
        }
        
        // attach the sender
        items.append(URLQueryItem(name: GameSenderQueryItemKey, value: uuid))

        return items
    }
}

extension Game {
    convenience init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        self.init(queryItems: queryItems)
    }
}
