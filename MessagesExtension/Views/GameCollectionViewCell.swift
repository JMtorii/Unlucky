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
    
    weak var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView()
        self.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
