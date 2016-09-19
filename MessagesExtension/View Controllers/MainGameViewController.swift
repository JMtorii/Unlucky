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
        titleLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
        titleLabel.font = UIFont(name: "Verdana", size: 20.0)
        titleLabel.textAlignment = .center
        
        self.view.addSubview(titleLabel)
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 110.0))
        
        // gameCollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        
        let gameCollectionView: UICollectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)), collectionViewLayout: layout)
        gameCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.backgroundColor = .white
        
        
        
        self.view.addSubview(gameCollectionView)
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10.0))
//        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
}

extension MainGameViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? GameCollectionViewCell else { fatalError("Unable to dequeue a BodyPartCell") }
        
        cell.imageView = UIImageView(image: UIImage(named: "back-card"))
        
        return cell
    }
}

extension MainGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Nothing to do here yet
    }

}

protocol MainGameViewControllerDelegate: class {
    func mainGameViewController(controller: MainGameViewController, didSelectAt index: Int)
}

