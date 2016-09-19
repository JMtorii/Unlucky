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
    
    
    // MARK: Helper methods
    
    private func presentViewController(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        let controller: UIViewController
        if presentationStyle == .compact {
            controller = instantiateStartGameViewController()
            
        } else {
            let game = Game(message: conversation.selectedMessage) ?? Game(numPicks: 6)            
            controller = instantiateMainGameViewController(game: game!)
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
        let controller = MainGameViewController()
        controller.delegate = self
        controller.game = game
        
        return controller
    }

}

extension MessagesViewController: StartGameViewControllerDelegate {
    func startGameViewControllerDidSelectStart(_ controller: StartGameViewController) {
        /*
         The user tapped the silhouette to start creating a new ice cream.
         Change the presentation style to `.expanded`.
         */
        requestPresentationStyle(.expanded)
    }
}

extension MessagesViewController: MainGameViewControllerDelegate {
    func mainGameViewController(controller: MainGameViewController, didSelectAt index: Int) {
        // TODO: take action here
    }
}
