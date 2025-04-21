//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Mihir Trivedi on 4/21/25.
//

import Testing
@testable import RecipeApp
import UIKit

struct EmptyRecipeURLProvider: URLProvider {
    var url: URL {
        return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    }
}

struct MalformedRecipeURLProvider: URLProvider {
    var url: URL {
        return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
    }
}

@Suite("ImageCacheTests")
struct ImageCacheTests {

    @Test("Image download and cache works correctly")
    func testImageDownloadAndCache() async throws {
        let cache = ImageCache.shared
        let imageURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!

        // download image and write in cache
        let image1 = try await cache.image(for: imageURL)
        #expect(image1 != nil)
        
        // get image from cache
        let image2 = try await cache.image(for: imageURL)
        #expect(image2 != nil)

        // both image downloaded and the one from cache should match
        #expect(image1.pngData() == image2.pngData(), "Cached image should match the original image")
    }
    
}


@Suite("RecipeAPI Tests")
struct RecipeAPITests {

    @Test("FetchRecipes should return valid data")
    func testFetchRecipesReturnsValidData() async throws {
        let api = RecipeAPI()
        let recipes = try await api.fetchRecipes()

        #expect(!recipes.isEmpty, "Recipes should not be empty")
        for recipe in recipes {
            #expect(!recipe.name.isEmpty, "Recipe name should not be empty")
            #expect(recipe.id != nil, "Recipe must have a UUID")
        }
    }
    
    @Test("FetchRecipes should throw decoding error for malformed data")
    func testFetchRecipesMalformed() async throws {
        let api = RecipeAPI(urlProvider: MalformedRecipeURLProvider())
        
        do {
            // Trying to fetch recipes with malformed data directly
            let recipes = try await api.fetchRecipes() // The API will return malformed data here
            #expect(Bool(false), "Expected to throw decoding error but got \(recipes)")
        } catch let error as RecipeAPIError {
            #expect(error == .decodingFailed, "Expected decoding error but got \(error)")
        } catch {
            #expect(Bool(false), "Unexpected error: \(error)")
        }
    }
    
    @Test("FetchRecipes should work on empty data")
    func testFetchRecipesEmpty() async throws {
        let api = RecipeAPI(urlProvider: EmptyRecipeURLProvider())
        
        do {
            // Trying to fetch recipes with malformed data directly
            let recipes = try await api.fetchRecipes() // The API will return malformed data here
            #expect(recipes.isEmpty, "Recipes should be empty")
        } catch {
            #expect(Bool(false), "Unexpected error: \(error)")
        }
    }

}
