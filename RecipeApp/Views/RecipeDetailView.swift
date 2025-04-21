//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/17/25.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    if let imageUrl = recipe.photoURLLarge {
                        CachedAsyncImage(url: imageUrl)
                            .frame(maxWidth: .infinity)
                            .scaledToFit()
                            .accessibilityLabel("Image of \(recipe.name)")
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Section(header: SectionHeader(text: "Details")) {
                    Text("Cuisine: \(recipe.cuisine)")
                    
                    if let sourceUrl = recipe.sourceURL {
                        Link("Original Recipe", destination: sourceUrl)
                    }
                    
                    if let youtubeUrl = recipe.youtubeURL {
                        Link("Watch on YouTube", destination: youtubeUrl)
                    }
                }
  
            }
        }
        .navigationTitle(recipe.name)
    }
}
