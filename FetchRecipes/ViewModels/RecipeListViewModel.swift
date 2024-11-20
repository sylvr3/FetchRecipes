//
//  RecipeListViewModel.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/17/24.
//

import Foundation
import SwiftUI

class RecipeListViewModel: ObservableObject {
    private let networkService = NetworkService() // NetworkService instance used to fetch recipes
    private var recipeActor = RecipeListActor()  // Actor instance for managing recipe updates safely using concurrency

    @Published var recipes: [Recipe] = [] // Array of Recipe objects bound to SwiftUI view
    @Published var errorMessage: String? // Used to display error messges

    // Load recipes from the API with provided recipes URL
    func loadRecipes(urlString: String = Constants.recipesURL) async {
        do {
            let fetchedRecipes = try await networkService.fetchRecipes(urlString: Constants.recipesURL)
            
            // Update the recipes in the actor safely using concurrency
            await recipeActor.updateRecipes(newRecipes: fetchedRecipes)
            
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                self.recipes = fetchedRecipes
                self.errorMessage = nil
            }
        } catch {
            // Error handling for UI updates on the main thread
            DispatchQueue.main.async {
                self.errorMessage = "Error fetching recipes: \(error.localizedDescription)"
                print("Error fetching recipes: \(error)")
            }
        }
    }
}
