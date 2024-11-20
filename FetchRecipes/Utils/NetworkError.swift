//
//  NetworkError.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/17/24.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}
