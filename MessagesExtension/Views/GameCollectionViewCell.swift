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
    
    var cardContainer: UIView!
    var frontCardImageView: UIImageView!
    var backCardImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backCardImage = UIImage(named: "back-card")
        let frontCardImage = UIImage(named: "front-card")

        // assumption is that back card and front card aspect ratio is the same
        let backCardAspect: CGFloat = (backCardImage!.size.height) / (backCardImage!.size.width);
        
        
        // self view
        self.backgroundColor = .green
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 150.0))
        
        
        // card container
        self.cardContainer = UIView()
        self.cardContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.cardContainer)
        self.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .height, relatedBy: .equal, toItem: self.cardContainer, attribute: .width, multiplier: backCardAspect, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))

        
        // back card
        self.backCardImageView = UIImageView(image: backCardImage)
        self.backCardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.backCardImageView.contentMode = .scaleAspectFit
        self.backCardImageView.isHidden = false
        
        self.cardContainer.addSubview(self.backCardImageView)
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .width, relatedBy: .equal, toItem: self.cardContainer, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .height, relatedBy: .equal, toItem: self.cardContainer, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .centerX, relatedBy: .equal, toItem: self.cardContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .centerY, relatedBy: .equal, toItem: self.cardContainer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        // front card
        self.frontCardImageView = UIImageView(image: frontCardImage)
        self.frontCardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.frontCardImageView.contentMode = .scaleAspectFit
        self.frontCardImageView.isHidden = true
        
        self.cardContainer.addSubview(self.frontCardImageView)
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .width, relatedBy: .equal, toItem: self.cardContainer, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .height, relatedBy: .equal, toItem: self.frontCardImageView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .centerX, relatedBy: .equal, toItem: self.cardContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .centerY, relatedBy: .equal, toItem: self.cardContainer, attribute: .centerY, multiplier: 1.0, constant: 0.0))
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
            UIView.transition(with: self.cardContainer, duration: 1.0, options: .transitionFlipFromRight, animations: { 
                self.backCardImageView.isHidden = false
                self.frontCardImageView.isHidden = true
            }, completion: nil)
            
        } else {
            UIView.transition(with: self.cardContainer, duration: 1.0, options: .transitionFlipFromRight, animations: { 
                self.backCardImageView.isHidden = true
                self.frontCardImageView.isHidden = false
            }, completion: nil)
            
        }
    }
}
