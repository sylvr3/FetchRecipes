//
//  FetchRecipesTests.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/17/24.
//

import XCTest
@testable import FetchRecipes

final class FetchRecipesTests: XCTestCase {
    
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    // Test for successful recipes response
    func testFetchRecipesSuccess() async throws {
        do {
            let recipes = try await networkService.fetchRecipes(urlString: Constants.recipesURL)
            XCTAssertNotNil(recipes, "Recipes should not be nil")
            XCTAssertGreaterThan(recipes.count, 0, "Recipes should contain at least one item")
        } catch {
            XCTFail("Fetching recipes failed: \(error)")
        }
    }
    
    // Test for empty recipes response
    func testFetchRecipesEmpty() async {
        do {
            let recipes = try await networkService.fetchRecipes(urlString: Constants.emptyRecipesURL)
            XCTAssertTrue(recipes.isEmpty, "Recipes should be empty")
        } catch {
            XCTFail("Fetching empty recipes failed with error: \(error)")
        }
    }
    
    // Test for malformed recipes response
    func testFetchRecipesMalformed() async {
        do {
            let recipes = try await networkService.fetchRecipes(urlString: Constants.malformedRecipesURL)
            XCTAssertNotNil(recipes, "Recipes should not be nil")
            XCTAssertGreaterThan(recipes.count, 0, "Recipes should contain at least one item")
        } catch {
            XCTFail("Fetching malformed recipes failed: \(error)")
        }
    }
}
