//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/16/25.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadRecipes() async {
        isLoading = true
        errorMessage = nil
        do {
            recipes = try await RecipeAPI.shared.fetchRecipes()
        } catch {
            errorMessage = "Failed to load recipes."
        }
        isLoading = false
    }
}
