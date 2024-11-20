
//
//  ImageCacheService.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/19/24.
//

import UIKit

// Service used to fetch, download, and cache images as needed
@MainActor
class ImageCacheService: ObservableObject {
    @Published var uiImage: UIImage?
    private static let cache = NSCache<NSString, UIImage>()
    
    // Fetch the image from the given URL asynchronously
    func fetchImage(_ url: URL?) async throws {
        guard let url = url else {
            throw ImageCacheServiceError.badUrl
        }
        
        // Try to retrieve image from cache first
        if let cachedImage = fetchFromCache(url) {
            uiImage = cachedImage
        } else {
            // Download the image if it is not found in cache
            try await downloadImage(from: url)
        }
    }
    
    // Return the image from cache if it is available
    private func fetchFromCache(_ url: URL) -> UIImage? {
        return Self.cache.object(forKey: url.absoluteString as NSString)
    }
    
    // Download the image, handle errors, and update the cache
    private func downloadImage(from url: URL) async throws {
        let request = URLRequest(url: filterURL(url: url))

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ImageCacheServiceError.badRequest
            }
            
            if httpResponse.statusCode != 200 {
                throw ImageCacheServiceError.serverError("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            guard let image = UIImage(data: data) else {
                throw ImageCacheServiceError.unsupportedImage
            }
            
            cacheImage(image, for: url)
            uiImage = image
        } catch {
            throw ImageCacheServiceError.serverError(error.localizedDescription)
        }
    }
    
    // Filters the URL if needed
    private func filterURL(url: URL) -> URL {
        var filteredURL = url.absoluteString
        if let dotRange = filteredURL.range(of: "/preview") {
            filteredURL.removeSubrange(dotRange.lowerBound..<filteredURL.endIndex)
        }
        guard let filteredURLObject = URL(string: filteredURL) else {
            return url
        }
        return filteredURLObject
    }
    
    // Caches the image for future use
    private func cacheImage(_ image: UIImage, for url: URL) {
        Self.cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}



