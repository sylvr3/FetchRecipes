//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/17/24.
//

import Foundation

// Model for a recipe
struct Recipe: Identifiable, Decodable {
    let id: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String
    let photoUrlSmall: String
    let sourceUrl: String?
    let youtubeUrl: String?

    // Maps the JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }

    // Default values provided for some properties using decodeIfPresent
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? "" // Provide default empty string if there is no recipe
        photoUrlLarge = try container.decode(String.self, forKey: .photoUrlLarge)
        photoUrlSmall = try container.decode(String.self, forKey: .photoUrlSmall)
        sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        youtubeUrl = try container.decodeIfPresent(String.self, forKey: .youtubeUrl)
    }
}
