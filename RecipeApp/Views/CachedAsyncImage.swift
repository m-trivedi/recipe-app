//
//  CachedAsyncImage.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/17/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    @State private var image: Image? = nil
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard !isLoading, image == nil, let url = url else { return }
        isLoading = true
        Task {
            do {
                let uiImage = try await ImageCache.shared.image(for: url)
                await MainActor.run {
                    self.image = Image(uiImage: uiImage)
                }
            } catch {
                print("Image load failed: \(error)")
            }
            isLoading = false
        }
    }
}

