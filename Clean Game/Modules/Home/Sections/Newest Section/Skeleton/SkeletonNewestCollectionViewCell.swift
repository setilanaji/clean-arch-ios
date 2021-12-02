//
//  SkeletonNewestCollectionViewCell.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/12/1.
//

import UIKit

class SkeletonNewestCollectionViewCell: UICollectionViewCell {

    static let identifier = "SkeletonNewestCollectionViewCell"
    
    @IBOutlet weak var gameThumbnail: RoundImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

}
