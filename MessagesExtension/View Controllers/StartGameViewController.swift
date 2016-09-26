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
        self.view.backgroundColor = UIColor(red: (61.0 / 255.0), green: (111.0 / 255.0), blue: (122.0 / 255.5), alpha: 1.0)
    
        // logoImageView
        let logoImageView = UIImageView()
        let logoImage = UIImage(named: "logo")
        let aspect: CGFloat = (logoImage!.size.height) / (logoImage!.size.width);
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(logoImageView)
        self.view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0))
        self.view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .height, relatedBy: .equal, toItem: logoImageView, attribute: .width, multiplier: aspect, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 30.0))
        
        // startButton
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .white
        startButton.setTitleColor(UIColor(red: (61.0 / 255.0), green: (111.0 / 255.0), blue: (122.0 / 255.5), alpha: 1.0), for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.layer.cornerRadius = 5.0
        startButton.addTarget(self, action: #selector(self.startButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(startButton)
        self.view.addConstraint(NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
        self.view.addConstraint(NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0))
        self.view.addConstraint(NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: startButton, attribute: .top, relatedBy: .equal, toItem: logoImageView, attribute: .bottom, multiplier: 1.0, constant: 20.0))
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
