//
//  Recipe.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/16/25.
//

import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Identifiable, Decodable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURLLarge: URL?
    let photoURLSmall: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case id = "uuid"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
