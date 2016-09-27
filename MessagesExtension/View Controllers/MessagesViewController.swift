//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Jun Torii on 2016-09-13.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    var cancelledGame: Game?
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        super.willBecomeActive(with: conversation);
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
        guard let conversation = activeConversation else { fatalError("Expected an active converstation") }
        presentViewController(for: conversation, with: presentationStyle)
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        cancelledGame = Game(message: message)
        print("Cancelled")
    }

    
    
    // MARK: Helper methods
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        
        let controller: UIViewController
        if presentationStyle == .compact {
            controller = instantiateStartGameViewController()
            
        } else {
            var game = Game(message: conversation.selectedMessage) ?? Game(numPicks: 6)    
            if (cancelledGame != nil) {
                game = cancelledGame
            }
            
            controller = (game?.isOver())! ? instantiateGameOverViewController(game: game!) : instantiateMainGameViewController(game: game!)
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
    
    private func instantiateMainGameViewController(game: Game) -> UIViewController {
        let controller = MainGameViewController(game: game, isCancelledGame: (self.cancelledGame != nil))
        controller.delegate = self
        
        return controller
    }
    
    private func instantiateGameOverViewController(game: Game) -> UIViewController {
        let controller = GameOverViewController(game: game)
        controller.delegate = self
        
        return controller
    }
    
    fileprivate func composeMessage(with game: Game, caption: String, session: MSSession? = nil, layoutImage: UIImage) -> MSMessage {
        var components = URLComponents()
        components.queryItems = game.queryItems
        
        let layout = MSMessageTemplateLayout()
        layout.image = layoutImage
        layout.caption = caption
        
        let message = MSMessage(session: session ?? MSSession())
        message.url = components.url!
        message.layout = layout
        
        return message
    }
}


// MARK: StartGameViewControllerDelegate

extension MessagesViewController: StartGameViewControllerDelegate {
    func startGameViewControllerDidSelectStart(_ controller: StartGameViewController) {
        /*
         The user tapped the silhouette to start creating a new ice cream.
         Change the presentation style to `.expanded`.
         */
        requestPresentationStyle(.expanded)
    }
}


// MARK: MainGameViewControllerDelegate

extension MessagesViewController: MainGameViewControllerDelegate {
    func mainGameViewControllerPickSelected(controller: MainGameViewController) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        guard let game = controller.game else { fatalError("Expected the controller to be displaying an ice cream") }
        
        let messageCaption: String = NSLocalizedString("Let's play", comment: "")
        
        // Create a new message with the same session as any currently selected message.
        let message = composeMessage(with: game, caption: messageCaption, session: conversation.selectedMessage?.session, layoutImage: UIImage(named:"logo")!)

        // Add the message to the conversation.
        conversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
        
        // reset cancelled game object
        self.cancelledGame = nil
        
        dismiss()
    }
    
    func mainGameViewControllerGameOver(controller: MainGameViewController) {
        let gameController = GameOverViewController(game: controller.game!)
        gameController.delegate = self
        
        // Remove any existing child controllers.
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller
        addChildViewController(gameController)
        
        gameController.view.frame = view.bounds
        gameController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameController.view)
        
        gameController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        gameController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        gameController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gameController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        gameController.didMove(toParentViewController: self)
    }
}


// MARK: GameOverViewControllerDelegate

extension MessagesViewController: GameOverViewControllerDelegate {
    func gameOverViewControllerConfirmed(controller: GameOverViewController) {
        guard let conversation = activeConversation else { fatalError("Expected a conversation") }
        guard let game = controller.game else { fatalError("Expected the controller to be displaying an ice cream") }
        
        let messageCaption: String = NSLocalizedString("I lost! :(", comment: "")
        
        // Create a new message with the same session as any currently selected message.
        let message = composeMessage(with: game, caption: messageCaption, session: conversation.selectedMessage?.session, layoutImage: UIImage(named: "logo")!)
        
        // Add the message to the conversation.
        conversation.insert(message) { error in
            if let error = error {
                print(error)
            }
        }
        
        // reset cancelled game object
        self.cancelledGame = nil
        
        dismiss()
    }
}
