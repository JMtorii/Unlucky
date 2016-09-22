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
        
        // scrollView
        let scrollView: UIScrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        // stackView
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        scrollView.addSubview(stackView)
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0.0))

        
        // titleLabel
        let titleLabel: UILabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString("Choose an item!", comment: "Title for the main game")
        titleLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
        titleLabel.font = UIFont(name: "Verdana", size: 20.0)
        titleLabel.textAlignment = .center
        titleLabel.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0))
        
        stackView.addArrangedSubview(titleLabel)
        
        
        // gameCollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 40.0, bottom: 20.0, right: 40.0)
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        let gameCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        gameCollectionView.backgroundColor = .white
        gameCollectionView.isScrollEnabled = false
        gameCollectionView.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0))
        
        stackView.addArrangedSubview(gameCollectionView)
    }
    
    private func addSpacerView(toStackView stackView:UIStackView, withHeight height:CGFloat) {
        let spacer: UIView = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.addConstraint(NSLayoutConstraint(item: spacer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height))
        
        stackView.addArrangedSubview(spacer)
    }
}

extension MainGameViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? GameCollectionViewCell else { fatalError("Unable to dequeue a BodyPartCell") }
        
        return cell
    }
}

extension MainGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell! else { fatalError("Unable to dequeue a BodyPartCell") }

        cell.flipCard()
    }

}

protocol MainGameViewControllerDelegate: class {
    func mainGameViewController(controller: MainGameViewController, didSelectAt index: Int)
}

