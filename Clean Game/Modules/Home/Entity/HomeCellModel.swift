//
//  HomeTableModel.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/28.
//

import Foundation

enum HomeCell {
    case genreSection(models: [GenreModel], rows: Int)
    case popularSection(models: [GameModel], rows: Int)
    case newestSection(models: [GameModel], rows: Int)
}

struct HomeCellModel {
    let title: String
}
