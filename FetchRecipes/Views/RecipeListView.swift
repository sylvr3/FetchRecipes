//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/18/24.
//

import SwiftUI

// Displays recipes in a list view
struct RecipeListView: View {
    var viewModel: [Recipe] // ViewModel used to hold recipes
        @State private var shouldCheckIfEmpty: Bool = false // Track delay trigger to give more time to load data

        var body: some View {
            // Check if should check after a 2 second delay
            Group {
                if shouldCheckIfEmpty {
                    if viewModel.isEmpty { // if there are no recipes, then display placeholder text
                        GeometryReader { geometry in
                            ScrollView(.vertical) {
                                VStack {
                                    Text("No recipes are available")
                                    Text("Pull down to refresh")
                                }
                                .frame(width: geometry.size.width)
                                .frame(minHeight: geometry.size.height)
                            }
                        }
                    } else {
                        List(viewModel) { recipe in
                            RecipeCell(viewModel: recipe) // load recipe into each cell
                        }.listRowSpacing(10)
                    }
                } else {
                    // ProgressView shows loading message
                    ProgressView("Loading recipes...").progressViewStyle(CircularProgressViewStyle())
                }
            }
            .onAppear {
                // Add a 2 second delay before checking if the viewModel is empty
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldCheckIfEmpty = true
                }
            }
        }
    }

    
    
    
