//
//  ImageCache.swift
//  RecipeApp
//
//  Created by Mihir Trivedi on 4/16/25.
//


import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = caches.appendingPathComponent("CustomImageCache")
        
        do {
            try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating cache directory: \(error)")
        }
    }
    
    func image(for url: URL) async throws -> UIImage {
        
        let fileName = url.absoluteString.data(using: .utf8)!.base64EncodedString()
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "+", with: "-") + ".jpg"
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        
        // check if image exists in cache
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                if let image = UIImage(data: data) {
                    // print("image found in cache")
                    return image
                }
                
                try? fileManager.removeItem(at: fileURL)
            } catch {
                print("Error reading image from cache: \(error)")
                try? fileManager.removeItem(at: fileURL)
            }
        }
        
        // download image if not found in cache
        let image = try await downloadImage(from: url)
        
        // write image to cache
        if let data = image.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL, options: .atomic)
            } catch {
                print("Error writing image to cache: \(error)")
            }
        }
        
        return image
    }
    
    private func downloadImage(from url: URL) async throws -> UIImage {
        
        // print("downloading image")
        
        // don't rely on URLCache
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        
        let session = URLSession(configuration: configuration)
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            guard let image = UIImage(data: data) else {
                throw URLError(.cannotDecodeContentData)
            }
            
            return image
        } catch {
            throw error
        }
    }
}
