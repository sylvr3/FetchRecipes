//
//  CachedImage.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/19/24.
//

import SwiftUI

// Used to store cached image as a UIImage
struct CachedImage: View {
    let url: URL?
    @State private var uiImage: UIImage? = nil
    @StateObject private var imageCacheService = ImageCacheService()
    
    var body: some View {
        VStack {
            // Loads the cached image using ImageCacheService. Show progress bar as image is being downloaded.
            if let uiImage = imageCacheService.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                ProgressView()
            }
        }
            .task {
                await downloadImage()
        }
    }
    
    // Downloads the image to display it on the device
    private func downloadImage() async {
        do {
            try await imageCacheService.fetchImage(url)
        } catch {
            print(error)
        }
    }

}



