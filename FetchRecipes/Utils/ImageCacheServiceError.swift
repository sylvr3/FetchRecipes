//
//  ImageCacheServiceError.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/19/24.
//

// Stores various types of networking and service errors involved with image caching
enum ImageCacheServiceError: Error {
    case badRequest
    case unsupportedImage
    case badUrl
    case serverError(String)
}
