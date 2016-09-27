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
    var isCancelledGame: Bool?
    
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var titleLabel: UILabel!
    var gameCollectionView: UICollectionView!
    
    init(game: Game, isCancelledGame: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
        self.isCancelledGame = isCancelledGame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
        
        // scrollView
        scrollView = UIScrollView()
        scrollView.backgroundColor = .yellow
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        // stackView
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .green
        
        scrollView.addSubview(stackView)
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .top, multiplier: 1.0, constant: 0.0))
        scrollView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0))

        
        // titleLabel
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString("Choose an item!", comment: "Title for the main game")
        titleLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
        titleLabel.font = UIFont(name: "Verdana", size: 20.0)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .black
        
        stackView.addArrangedSubview(titleLabel)
        scrollView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0))
                
        
        // gameCollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 40.0, bottom: 20.0, right: 40.0)
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        gameCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        gameCollectionView.backgroundColor = .white
        gameCollectionView.isScrollEnabled = false
        
        stackView.addArrangedSubview(gameCollectionView)
        print("Height: \(gameCollectionView.collectionViewLayout.collectionViewContentSize.height)")

        stackView.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0))        
    }
}

extension MainGameViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as? GameCollectionViewCell else { fatalError("Unable to dequeue a BodyPartCell") }
        
        if (game?.picks[indexPath.row].isPicked)! {
            cell.enableCard()
        }
        
        return cell
    }
}

extension MainGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell! else { fatalError("Unable to dequeue a BodyPartCell") }

        cell.flipCard(completion: { 
            self.game?.picks[indexPath.row].isPicked = true
            
            if (self.game?.picks[indexPath.row].isUnlucky)! {
                self.delegate?.mainGameViewControllerGameOver(controller: self)
                
            } else {
                self.delegate?.mainGameViewControllerPickSelected(controller: self)
            }
        })
    }
}

protocol MainGameViewControllerDelegate: class {
    func mainGameViewControllerPickSelected(controller: MainGameViewController)
    
    func mainGameViewControllerGameOver(controller: MainGameViewController)
}

