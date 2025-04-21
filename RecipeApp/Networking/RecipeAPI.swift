//
//  RecipeAPI.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/16/25.
//

import Foundation

// url to fetch recipes from
struct RecipeURLProvider: URLProvider {
    var url: URL {
        return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    }
}

enum RecipeAPIError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
}

struct RecipeAPI {
    
    // injecting urlprovider
    private let urlProvider: URLProvider
    
    static let shared = RecipeAPI()

    init(urlProvider: URLProvider = RecipeURLProvider()) {
        self.urlProvider = urlProvider
    }
    
    func fetchRecipes() async throws -> [Recipe] {
        
        // print("network request")
        let (data, response) = try await URLSession.shared.data(from: urlProvider.url)

        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw RecipeAPIError.invalidResponse
        }

        do {
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return decoded.recipes
        } catch {
            throw RecipeAPIError.decodingFailed
        }
    }
}
