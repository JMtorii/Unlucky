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
        let frontLuckyCardImage = UIImage(named: "front-lucky-card")
        
        
        // card container
        self.cardContainer = UIView()
        self.cardContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.cardContainer)
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.cardContainer, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        // back card
        self.backCardImageView = UIImageView(image: backCardImage)
        self.backCardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.backCardImageView.contentMode = .scaleAspectFit
        self.backCardImageView.isHidden = false
        self.backCardImageView.clipsToBounds = true
        
        self.cardContainer.addSubview(self.backCardImageView)
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .top, relatedBy: .equal, toItem: self.cardContainer, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .bottom, relatedBy: .equal, toItem: self.cardContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .left, relatedBy: .equal, toItem: self.cardContainer, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.backCardImageView, attribute: .right, relatedBy: .equal, toItem: self.cardContainer, attribute: .right, multiplier: 1.0, constant: 0.0))
        
        
        // front card
        self.frontCardImageView = UIImageView(image: frontLuckyCardImage)
        self.frontCardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.frontCardImageView.contentMode = .scaleAspectFit
        self.frontCardImageView.isHidden = true
        self.frontCardImageView.clipsToBounds = true

        self.cardContainer.addSubview(self.frontCardImageView)
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .top, relatedBy: .equal, toItem: self.cardContainer, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .bottom, relatedBy: .equal, toItem: self.cardContainer, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .left, relatedBy: .equal, toItem: self.cardContainer, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self.frontCardImageView, attribute: .right, relatedBy: .equal, toItem: self.cardContainer, attribute: .right, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Don't I need this?
//    override func prepareForReuse() {
//        self.frontCardImageView.image = nil
//        self.backCardImageView.image = nil
//    }
    
    func setState(isUnlucky: Bool) {
        self.frontCardImageView.image = (isUnlucky) ? UIImage(named: "front-unlucky-card") : UIImage(named: "front-lucky-card")
    }
    
    func flipCard(completion: @escaping (Void) -> Void) {
        if (self.frontCardImageView.isHidden) {
            UIView.transition(with: self.cardContainer, duration: 1.0, options: .transitionFlipFromRight, animations: { 
                self.enableCard()
            }, completion: { finished in
                completion()
            });
        }
    }
    
    func enableCard() {
        self.backCardImageView.isHidden = true
        self.frontCardImageView.isHidden = false
    }
}
