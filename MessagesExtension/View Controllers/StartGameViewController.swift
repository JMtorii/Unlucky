//
//  StartGameViewController.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-15.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit

class StartGameViewController: UIViewController {
    
    weak var delegate: StartGameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.view
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor(red: (61.0 / 255.0), green: (111.0 / 255.0), blue: (122.0 / 255.5), alpha: 1.0)
        
        
        // why the fuck do I have to do this. shouldn't the bottomlayoutguide handle this?
        let bottomContainer = UIView()
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomContainer)
        
        self.view.addConstraint(NSLayoutConstraint(item: bottomContainer, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -44.0))
        self.view.addConstraint(NSLayoutConstraint(item: bottomContainer, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: bottomContainer, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: bottomContainer, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
        
        
        // container view
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .gray
                
        bottomContainer.addSubview(containerView)
        bottomContainer.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: bottomContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        bottomContainer.addConstraint(NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: bottomContainer, attribute: .width, multiplier: 0.75, constant: 0.0))
        bottomContainer.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: bottomContainer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        bottomContainer.addConstraint(NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: bottomContainer, attribute: .height, multiplier: 0.8, constant: 0.0))
        
    
        // logoImageView
        let logoImageView = UIImageView()
        let logoImage = UIImage(named: "logo")  
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.backgroundColor = .yellow
        logoImageView.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)
        logoImageView.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        containerView.addSubview(logoImageView);
        containerView.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        containerView.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))

        
        // startButton
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .white
        startButton.setTitleColor(UIColor(red: (61.0 / 255.0), green: (111.0 / 255.0), blue: (122.0 / 255.5), alpha: 1.0), for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.layer.cornerRadius = 5.0
        startButton.addTarget(self, action: #selector(self.startButtonClicked), for: .touchUpInside)
        
        containerView.addSubview(startButton)
        containerView.addConstraint(NSLayoutConstraint(item: startButton, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: startButton, attribute: .top, relatedBy: .equal, toItem: logoImageView, attribute: .bottom, multiplier: 1.0, constant: 10.0))
        containerView.addConstraint(NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        containerView.addConstraint(NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    func startButtonClicked(sender:UIButton!) {
        NSLog("Hi");
        self.delegate?.startGameViewControllerDidSelectStart(self)
    }
}

/**
 A delegate protocol for the `StartGameViewController` class.
 */
protocol StartGameViewControllerDelegate: class {
    // Called when user decides to start the game
    func startGameViewControllerDidSelectStart(_ controller: StartGameViewController)
}
