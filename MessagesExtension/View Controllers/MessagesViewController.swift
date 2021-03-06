//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Jun Torii on 2016-09-13.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit
import Foundation
import Messages

let UserDefaultsCancelledRawPicksKey = "cancelledRawPicks"
let UserDefaultsCancelledSenderKey = "cancelledSender"
let MessagesDefaultCardCount = 6


class MessagesViewController: MSMessagesAppViewController {
        
    // MARK: - Conversation Handling
        
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        super.willBecomeActive(with: conversation)
        
        print("willBecomeActive: started")
        
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        presentViewController(for: conversation, with: presentationStyle)
        
        print("willTransition: starts")
        if presentationStyle == .compact && self.presentationStyle == .expanded {
            print("Changing to compact - transition")
            if let decodedRawPicksData = UserDefaults.standard.object(forKey: UserDefaultsCancelledRawPicksKey) as? NSData, let decodedSender = UserDefaults.standard.string(forKey: UserDefaultsCancelledSenderKey) {
                if let decodedRawPicks = NSKeyedUnarchiver.unarchiveObject(with: decodedRawPicksData as Data) as? [String] {
                    print("Decoded cancelled game")
                    let game = Game(rawPicks: decodedRawPicks, sender: decodedSender)

                    let message = composeMessage(with: game!, session: conversation.selectedMessage?.session, uuid: conversation.localParticipantIdentifier.uuidString)
                    
                    conversation.insert(message) { error in
                        if let error = error {
                            print(error)
                        }
                    }
                    
                    dismiss()
                }
            }
        }
    }
    
    override func requestPresentationStyle(_ presentationStyle: MSMessagesAppPresentationStyle) {
        super.requestPresentationStyle(presentationStyle)
        
        print("requestPresentationStyle: starts")
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        super.didCancelSending(message, conversation: conversation)
        
        print("didCancelSending")
        
        guard let game = Game(message: message) else { fatalError("Expected a valid game") }
        
        if !(game.isFirstMove()) {
            let userDefaults = UserDefaults.standard
            var rawPicks: [String] = []
            for pick in game.picks {
                rawPicks.append(pick.rawValue())
            }
            
            let encodedRawPicksData = NSKeyedArchiver.archivedData(withRootObject: rawPicks)
            userDefaults.set(encodedRawPicksData, forKey: UserDefaultsCancelledRawPicksKey)
            userDefaults.set(game.sender, forKey: UserDefaultsCancelledSenderKey)
            
            userDefaults.synchronize()  
        }
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {        
        super.didStartSending(message, conversation: conversation)
        
        print("didStartSending")

        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
    }
    
    // MARK: Helper methods
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        
        let controller: UIViewController!
        var game: Game?
        
        if presentationStyle == .compact {
            controller = instantiateStartGameViewController()
            
        } else {
            if let decodedRawPicksData = UserDefaults.standard.object(forKey: UserDefaultsCancelledRawPicksKey) as? NSData, let decodedSender = UserDefaults.standard.string(forKey: UserDefaultsCancelledSenderKey) {
                if let decodedRawPicks = NSKeyedUnarchiver.unarchiveObject(with: decodedRawPicksData as Data) as? [String] {
                    print("Decoded cancelled game in presentViewController")
                    game = Game(rawPicks: decodedRawPicks, sender: decodedSender)
                    
                } else {
                    game = Game(message: conversation.selectedMessage) ?? Game(numPicks: MessagesDefaultCardCount)!
                }
                
            } else {
                game = Game(message: conversation.selectedMessage) ?? Game(numPicks: MessagesDefaultCardCount)!            
            }
            
            controller = instantiateMainGameViewController(game: game!, currentUuid: conversation.localParticipantIdentifier.uuidString)
        }
            
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller
        addChildViewController(controller)
        
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        controller.didMove(toParentViewController: self)
    }
    
    private func instantiateStartGameViewController() -> UIViewController {
        let controller = StartGameViewController()
        controller.delegate = self
        
        return controller
    }
    
    private func instantiateMainGameViewController(game: Game, currentUuid: String) -> UIViewController {
        let controller = MainGameViewController(game: game, currentUuid: currentUuid)
        controller.delegate = self
        
        return controller
    }
    
    fileprivate func composeMessage(with game: Game, session: MSSession? = nil, uuid: String) -> MSMessage {
        var components = URLComponents()
        components.queryItems = game.queryItems(uuid: uuid)
                
        let layout = MSMessageTemplateLayout()
        layout.image = game.isOver() ? UIImage(named: "message-unlucky") : UIImage(named: "message-lucky")
        layout.caption = game.isOver() ? "I'm unlucky... 😞😿" : "I'm lucky! 😉😸"
        
        let message = MSMessage(session: session ?? MSSession())
        message.url = components.url!
        message.layout = layout
        
        return message
    }
}


// MARK: StartGameViewControllerDelegate

extension MessagesViewController: StartGameViewControllerDelegate {
    func startGameViewControllerDidSelectStart(_ controller: StartGameViewController) {
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
        
        requestPresentationStyle(.expanded)
    }
}


// MARK: MainGameViewControllerDelegate

extension MessagesViewController: MainGameViewControllerDelegate {
    func mainGameViewControllerPickSelected(controller: MainGameViewController) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        guard let game = controller.game else { fatalError("Expected the controller to be displaying an ice cream") }
                
        // Create a new message with the same session as any currently selected message.
        let message = composeMessage(with: game, session: conversation.selectedMessage?.session, uuid: conversation.localParticipantIdentifier.uuidString)

        // Add the message to the conversation.
        conversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
        
        dismiss()
    }
}

