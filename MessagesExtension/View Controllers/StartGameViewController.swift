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
        
        
        // why the fuck do I have to do this. shouldn't the bottomlayoutguide handle this?
        let containerWithBottomInset = UIView()
        containerWithBottomInset.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerWithBottomInset)
        
        self.view.addConstraint(NSLayoutConstraint(item: containerWithBottomInset, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -44.0))
        self.view.addConstraint(NSLayoutConstraint(item: containerWithBottomInset, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: containerWithBottomInset, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: containerWithBottomInset, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
        
        
        // background image
        let backgroundImageView = UIImageView(image: UIImage(named: "unlucky-start-background"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleToFill
        
        containerWithBottomInset.addSubview(backgroundImageView)
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .centerX, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .width, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .centerY, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .height, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .height, multiplier: 1.0, constant: 0.0))

        
        // startButton
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .black
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 20.0);
        startButton.layer.cornerRadius = 5.0
        startButton.addTarget(self, action: #selector(self.startButtonClicked), for: .touchUpInside)
        
        containerWithBottomInset.addSubview(startButton)
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: startButton, attribute: .bottom, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .bottom, multiplier: 1.0, constant: -20.0))
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .height, multiplier: 0.25, constant: 0.0))
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .width, multiplier: 0.6, constant: 0.0))
        containerWithBottomInset.addConstraint(NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: containerWithBottomInset, attribute: .centerX, multiplier: 1.0, constant: 0.0))
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
