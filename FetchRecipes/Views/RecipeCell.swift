//
//  RecipeCell.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/18/24.
//

import SwiftUI

// Displays recipe information in each cell. Allows user to view the image of the dish, the name, cuisine, view the recipe if it has a source URL, and play its YouTube video.
struct RecipeCell: View {
    
    let viewModel: Recipe
    @Environment(\.openURL) private var openURL: OpenURLAction
    @State private var showToast = false
    
    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                // Display the image, cached to improve app performance
                CachedImage(url: URL(string: viewModel.photoUrlSmall))
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                // Play button to play YouTube video
                if let youtubeUrlStr = viewModel.youtubeUrl, !youtubeUrlStr.isEmpty {
                    VStack {
                        Image(systemName: "play.fill") // Used system image for Play button
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .opacity(0.8)
                    }
                    .offset(x: 0, y: -10)
                    .onTapGesture {
                        // If YouTube URL exists, open the link when the photo is tapped
                        if let youtubeUrlStr = viewModel.youtubeUrl, let youtubeUrl = URL(string: youtubeUrlStr) {
                            print("Opening YouTube Video URL: \(youtubeUrl)")
                            openURL(youtubeUrl)
                        }
                    }
                }
            }
            
            // Display name and cuisine
            VStack(alignment: .leading) {
                Text(viewModel.name)
                    .font(.headline)
                Text(viewModel.cuisine)
                    .font(.subheadline)
                
                // Check if the source URL exists. If it does, then the button is blue and the recipe is displayed after pressing the View Recipe button. Otherwise, it is grey and a toast message is displayed after View Recipe button is pressed.
                
                Button {
                    if let sourceUrlStr = viewModel.sourceUrl, let sourceUrl = URL(string: sourceUrlStr) {
                        openURL(sourceUrl)
                    } else {
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false  // Hide toast message after 2 seconds
                        }
                    }
                } label: {
                    Text("View Recipe")
                        .font(.subheadline)
                        .tint(.white)
                        .frame(maxWidth: 100)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(viewModel.sourceUrl != nil ? Color.blue : Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }
        }
        .overlay(
            // Toast message
            GeometryReader { geometry in
                VStack {
                    if showToast {
                        Text("No recipe available.")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                            .padding(.horizontal, 20) // Adds horizontal padding
                            .frame(width: geometry.size.width) // Limit width to the screen width
                            .transition(.slide)
                            .animation(.easeInOut(duration: 0.5))
                    }
                }
                .padding(.bottom, 50)
            }
            , alignment: .bottom
        )
    }
}
