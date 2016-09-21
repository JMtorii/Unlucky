//
//  GameCollectionViewCell.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-18.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GameCollectionViewCell"
    
    var frontCardImageView: UIImageView!
    var backCardImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
        
        // back card
        self.backCardImageView = UIImageView(image: UIImage(named: "back-card"))
        self.backCardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.backCardImageView.isHidden = false
        
        self.addSubview(backCardImageView)
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        // front card
        self.frontCardImageView = UIImageView(image: UIImage(named: "front-card"))
        self.frontCardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.frontCardImageView.isHidden = true
        
        self.addSubview(frontCardImageView)
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.frontCardImageView.image = nil
        self.backCardImageView.image = nil
    }
    
    func flipCard() {
        if (self.backCardImageView.isHidden) {
            UIView.transition(with: self, duration: 1.0, options: .transitionFlipFromRight, animations: { 
                self.backCardImageView.isHidden = false
                self.frontCardImageView.isHidden = true
            }, completion: nil)
            
        } else {
            UIView.transition(with: self, duration: 1.0, options: .transitionFlipFromRight, animations: { 
                self.backCardImageView.isHidden = true
                self.frontCardImageView.isHidden = false
            }, completion: nil)
            
        }
    }
}
