//
//  GameReponse.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/9.
//

import Foundation

struct GameResponse: Codable {
    let id: Int
    var name: String? = ""
    var released: String? = ""
    var rating: Float? = 0
    var ratingsCount: Int? = 0
    var backgroundImage: String? = ""
    var description: String? = ""
    var website: String? = ""
    var parentPlatforms: [BasePlatformResponse]? = []
    var platforms: [BasePlatformResponse]? = []
    var genres: [GenreReponse]? = []
    var publishers: [PublisherResponse]? = []

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case released = "released"
        case rating = "rating"
        case ratingsCount = "ratings_count"
        case backgroundImage = "background_image"
        case description = "description_raw"
        case website
        case parentPlatforms = "parent_platforms"
        case platforms = "platforms"
        case genres
        case publishers
    }
}
