//
//  NewestCollectionViewCell.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/12/1.
//

import UIKit

class NewestCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewestCollectionViewCell"
    
    @IBOutlet weak var gameThumbnail: RoundImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIImageView!
    @IBOutlet weak var gameGenre: UILabel!
    
    var tapItem: ((Int) -> Void)?
    var tapFavorite: (() -> Void)?
    
    private var isFavorite = false {
        didSet{
            DispatchQueue.main.async {
                self.changeFavoriteUI()
            }
        }
    }
    
    private var game: GameModel? {
        didSet {
            guard let game = game else {
                return
            }
            gameTitle.text = game.name
            gameGenre.text = game.released.toDate().toString(format: "dd MMMM yyyy")
            gameThumbnail.setImage(with: game.backgroundImage)
            isFavorite = game.isFavorite
        }
    }
    
    func set(data: GameModel) {
        self.game = data
    }
    
    func configure() {
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapGame(_:))))
        favoriteButton.isUserInteractionEnabled = true
        favoriteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapFavoriteButton(_:))))
    }
    
    @objc func tapGame(_ sender: Any) {
        contentView.showAnimation {
            guard let id = self.game?.id else {
                return
            }
            self.tapItem?(id)
        }
    }
    
    @objc func tapFavoriteButton(_ sender: Any) {
        favoriteButton.showAnimation {
                self.isFavorite = !self.isFavorite
                self.changeLocal()
        }
    }
    
    private func changeFavoriteUI() {
        print(self.isFavorite)
        if self.isFavorite {
            self.favoriteButton.tintColor = .red
        } else {
            self.favoriteButton.tintColor = .systemGray4
        }
    }
    
    private func changeLocal(){
        tapFavorite?()
    }
}
