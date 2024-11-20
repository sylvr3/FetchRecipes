//
//  NetworkService.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/17/24.
//

import Foundation

class NetworkService {
    // Fetch recipes from the API
    func fetchRecipes(urlString: String) async throws -> [Recipe] {
        // Validate the URL
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            // Perform the network request using await
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Check for a valid HTTP response (status code 200)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            // Decode the data into the RecipeListResponse object
            let decodedResponse = try JSONDecoder().decode(RecipeListResponse.self, from: data)
            return decodedResponse.recipes
        } catch {
            // Rethrow a specific error after handling it
            if let networkError = error as? URLError {
                throw networkError
            } else {
                throw NetworkError.decodingError
            }
        }
    }
}
