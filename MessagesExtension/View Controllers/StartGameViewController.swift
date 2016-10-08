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
        
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0.0
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsetsMake(0.0, 30.0, 0.0, 30.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        self.view.addSubview(stackView)
        self.view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0))

//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .gray
//        
//        self.view.addSubview(containerView)
//        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: containerView.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0))
//        self.view.addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: containerView.superview, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        let spacer1 = UIView()
        spacer1.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(spacer1)
        stackView.addConstraint(NSLayoutConstraint(item: spacer1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0))
        
    
        // logoImageView
        let logoImageView = UIImageView()
        let logoImage = UIImage(named: "logo")  
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.backgroundColor = .yellow
        
//        stackView.addArrangedSubview(logoImageView);
//        stackView.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 70.0))
        
        
        // startButton
        let startButton = UIButton()
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.backgroundColor = .white
        startButton.setTitleColor(UIColor(red: (61.0 / 255.0), green: (111.0 / 255.0), blue: (122.0 / 255.5), alpha: 1.0), for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.layer.cornerRadius = 5.0
        startButton.addTarget(self, action: #selector(self.startButtonClicked), for: .touchUpInside)
        
//        stackView.addArrangedSubview(startButton)
//        stackView.addConstraint(NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0))
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
