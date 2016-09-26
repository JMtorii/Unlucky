//
//  GameOverViewController.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-18.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    weak var delegate: GameOverViewControllerDelegate?
    
    var game: Game?
    
    init(game: Game) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        // container view
        let containerView: UIView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .yellow
        
        self.view.addSubview(containerView)
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        // game over label
        let gameOverLabel: UILabel = UILabel()
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        gameOverLabel.textColor = .black
        gameOverLabel.text = NSLocalizedString("You're Unlucky!", comment: "Game Over text in GameOverViewController")
        gameOverLabel.textAlignment = .center
        gameOverLabel.font = UIFont(name: "Verdana", size: 35.0)
        gameOverLabel.backgroundColor = .green
        
        containerView.addSubview(gameOverLabel)
        containerView.addConstraint(NSLayoutConstraint(item: gameOverLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        
        // game over button
        let gameOverButton: UIButton = UIButton()
        gameOverButton.translatesAutoresizingMaskIntoConstraints = false
        gameOverButton.setTitle("I admit I lost", for: .normal)
        gameOverButton.addTarget(self, action: #selector(self.gameOverButtonClicked), for: .touchUpInside)
        gameOverButton.backgroundColor = .blue
        
        containerView.addSubview(gameOverButton)
        containerView.addConstraint(NSLayoutConstraint(item: gameOverButton, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverButton, attribute: .top, relatedBy: .equal, toItem: gameOverLabel, attribute: .bottom, multiplier: 1.0, constant: 100.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: gameOverButton, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    func gameOverButtonClicked(sender:UIButton!) {
        NSLog("Hi");
        self.delegate?.gameOverViewControllerConfirmed(controller: self)
    }
}

protocol GameOverViewControllerDelegate: class {
    func gameOverViewControllerConfirmed(controller: GameOverViewController)
}
