//
//  RecipeRowView.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/16/25.
//

import Foundation
import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe

    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            HStack {
                if let imageUrl = recipe.photoURLSmall {
                    CachedAsyncImage(url: imageUrl)
                        .frame(width: 50, height: 50)
                        .accessibilityLabel("Image of \(recipe.name)")
                }

                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

