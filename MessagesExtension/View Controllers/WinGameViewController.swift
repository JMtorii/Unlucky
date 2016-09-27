//
//  WinGameViewController.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-27.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit

class WinGameViewController: UIViewController {
    
    weak var delegate: WinGameViewControllerDelegate?
    
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
        
        
        // win label
        let winLabel: UILabel = UILabel()
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        winLabel.textColor = .black
        winLabel.text = NSLocalizedString("You Won!", comment: "Win text in WinGameViewController")
        winLabel.textAlignment = .center
        winLabel.font = UIFont(name: "Verdana", size: 35.0)
        winLabel.backgroundColor = .green
        
        containerView.addSubview(winLabel)
        containerView.addConstraint(NSLayoutConstraint(item: winLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: winLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        containerView.addConstraint(NSLayoutConstraint(item: winLabel, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: winLabel, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        
        // game over button
        let winButton: UIButton = UIButton()
        winButton.translatesAutoresizingMaskIntoConstraints = false
        winButton.setTitle("Quit Game", for: .normal)
        winButton.addTarget(self, action: #selector(self.winButtonClicked), for: .touchUpInside)
        winButton.backgroundColor = .blue
        
        containerView.addSubview(winButton)
        containerView.addConstraint(NSLayoutConstraint(item: winButton, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: winButton, attribute: .top, relatedBy: .equal, toItem: winLabel, attribute: .bottom, multiplier: 1.0, constant: 100.0))
        containerView.addConstraint(NSLayoutConstraint(item: winButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0))
        containerView.addConstraint(NSLayoutConstraint(item: winButton, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0))
        containerView.addConstraint(NSLayoutConstraint(item: winButton, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    func winButtonClicked(sender:UIButton!) {
        NSLog("Hi");
        self.delegate?.winGameViewControllerClosed(controller: self)
    }
}

protocol WinGameViewControllerDelegate: class {
    func winGameViewControllerClosed(controller: WinGameViewController)
}
