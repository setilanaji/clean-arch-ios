//
//  GameMapper.swift
//  Clean Game
//
//  Created by Yudha Setyaji on 2021/11/9.
//

import Foundation

final class GameMapper {
    static func mapGameResponsesToDomains(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        return gameResponses.map { result in
            return mapGameResponseToDomain(input: result)
        }
    }
    
    static func mapGameResponseToDomain(
        input gameResponse: GameResponse
    ) -> GameModel {
        return GameModel(
            id: gameResponse.id,
            name: gameResponse.name ?? "",
            released: gameResponse.released ?? "",
            rating: gameResponse.rating ?? 0,
            ratingsCount: gameResponse.ratingsCount ?? 0,
            backgroundImage: gameResponse.backgroundImage ?? "",
            description: gameResponse.description ?? "",
            website: gameResponse.website ?? ""
        )
    }
}
