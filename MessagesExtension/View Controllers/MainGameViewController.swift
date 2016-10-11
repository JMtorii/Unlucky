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
    
    var scrollView: UIScrollView!
    var stackView: UIStackView!
    var titleLabel: UILabel!
    var gameCollectionView: UICollectionView!
    
    init(game: Game, currentUuid: String) {
        super.init(nibName: nil, bundle: nil)
        self.game = game
        self.currentUuid = currentUuid
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
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
        gameCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gameCollectionView.delegate = self
        gameCollectionView.translatesAutoresizingMaskIntoConstraints = false
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        gameCollectionView.backgroundColor = .white
        gameCollectionView.isScrollEnabled = false
        
        stackView.addArrangedSubview(gameCollectionView)
        print("Height: \(gameCollectionView.collectionViewLayout.collectionViewContentSize.height)")

        stackView.addConstraint(NSLayoutConstraint(item: gameCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 500.0))
        
        if self.game?.sender == self.currentUuid {
            titleLabel.text = NSLocalizedString("It's your buddy's turn!", comment: "Temporary title for the main game")
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
        
//        cell.setNeedsUpdateConstraints()
//        cell.updateConstraintsIfNeeded()
        
        if (self.game?.picks[indexPath.row].isPicked)! {
            cell.enableCard()
        }
        
        return cell
    }
}

extension MainGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.game?.sender != self.currentUuid {
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
}

extension MainGameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let windowRect = self.view.window?.frame;
        let windowWidth = windowRect?.size.width;
        let cellWidth = windowWidth! * 0.23
        let cellHeight = cellWidth * 1.5
        
//        return CGSize(width: cellWidth, height: cellHeight)
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
    
    func mainGameViewControllerGameOver(controller: MainGameViewController)
}

