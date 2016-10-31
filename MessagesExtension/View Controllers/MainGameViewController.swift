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
    var currentUuid: String?
    
    
    init(game: Game, currentUuid: String) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
        self.currentUuid = currentUuid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {  
        
        // backgroundView
        let backgroundView = UIImageView(image: UIImage(named: "game-background"))
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundView)
        self.view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: backgroundView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
        
        
        // titleBackgroundView
        let titleBackgroundView = UIImageView(image: UIImage(named:"title-background"))
        titleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundView.contentMode = .scaleToFill
        
        self.view.addSubview(titleBackgroundView)
        self.view.addConstraint(NSLayoutConstraint(item: titleBackgroundView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.13, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleBackgroundView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.9, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleBackgroundView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleBackgroundView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 30.0))
        
        
        // titleLabel
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = NSLocalizedString("Choose a card!", comment: "Title for the main game")
        titleLabel.textColor = UIColor(white: 1.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightRegular)
        titleLabel.textAlignment = .left
        
        self.view.addSubview(titleLabel)
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: titleBackgroundView, attribute: .height, multiplier: 0.83, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: titleBackgroundView, attribute: .width, multiplier: 0.9, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 40.0))
        self.view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: titleBackgroundView, attribute: .top, multiplier: 1.0, constant: 0.0))

        
        // gameCollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        let gameCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        gameCollectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        gameCollectionView.isScrollEnabled = true
        gameCollectionView.allowsMultipleSelection = false
        
        self.view.addSubview(gameCollectionView)
        print("Height: \(gameCollectionView.collectionViewLayout.collectionViewContentSize.height)")
        
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .top, relatedBy: .equal, toItem: titleBackgroundView, attribute: .bottom, multiplier: 1.0, constant: 15.0))
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0))
                
        if (self.game?.isOver())! {
            titleLabel.text = NSLocalizedString("The game is over!", comment: "Title for game that is over")
        } else if self.game?.sender == self.currentUuid {
            titleLabel.text = NSLocalizedString("It's your buddy's turn!", comment: "Title for game where it is the buddy's turn")
        }
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
        
        cell.setState(isUnlucky: self.game!.picks[indexPath.row].isUnlucky)

        if (self.game?.picks[indexPath.row].isPicked)! {
            cell.enableCard()
        }
        
        print("index: \(indexPath)")
        
        return cell
    }
}

extension MainGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.game?.sender != self.currentUuid {
            guard let cell = collectionView.cellForItem(at: indexPath) as! GameCollectionViewCell! else { fatalError("Unable to dequeue a GameCollectionCell") }
            
            if !((self.game?.isOver())!) && self.game?.sender != self.currentUuid {
                cell.flipCard(completion: { 
                    self.game?.picks[indexPath.row].isPicked = true
                    self.delegate?.mainGameViewControllerPickSelected(controller: self)
                })
            }
        }
    }
}

extension MainGameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let windowRect = self.view.window?.frame;
        let windowWidth = windowRect?.size.width;
        let cellWidth = windowWidth! * 0.23
        let cellHeight = cellWidth * 1.5
        
        print("cellWidth: \(cellWidth), cellHeight: \(cellHeight)")
        return CGSize(width: cellWidth, height: cellHeight)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let windowRect = self.view.window?.frame;
        let windowWidth = windowRect?.size.width;
        let sideInset = windowWidth! * 0.1
        
        print("sideInset: \(sideInset)")
        return UIEdgeInsetsMake(40.0, sideInset, 40.0, sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let windowRect = self.view.window?.frame;
        let windowWidth = windowRect?.size.width;
        let lineSpacing = windowWidth! * 0.03
        
        print("line spacing: \(lineSpacing)")
        return lineSpacing
    }
}

protocol MainGameViewControllerDelegate: class {
    func mainGameViewControllerPickSelected(controller: MainGameViewController)    
}

