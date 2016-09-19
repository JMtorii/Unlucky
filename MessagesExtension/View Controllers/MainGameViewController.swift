//
//  MainGameViewController.swift
//  Unlucky
//
//  Created by Jun Torii on 2016-09-15.
//  Copyright © 2016 JMtorii. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    
    weak var delegate: MainGameViewControllerDelegate?
    var game: Game?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
        
        // titleLabel
        let titleLabel: UILabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString("Choose an item!", comment: "Title for the main game")
        
        self.view.addSubview(titleLabel)
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 20.0))
        
        // gameCollectionView
        let gamecollectionView: UICollectionView = UICollectionView()
    }
}

extension MainGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? GameCollectionViewCell else { fatalError("Unable to dequeue a BodyPartCell") }
        
//        let iceCreamPart = iceCreamParts[indexPath.row]
//        cell.imageView.image = iceCreamPart.image
        
        return cell
    }
}

protocol MainGameViewControllerDelegate: class {
    func mainGameViewController(controller: MainGameViewController, didSelectAt index: Int)
}

