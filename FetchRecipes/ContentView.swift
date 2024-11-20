//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Sylvia Barnai on 11/17/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: RecipeListViewModel = RecipeListViewModel()
    
    var body: some View {
        RecipeListView(viewModel: viewModel.recipes)
            .task {
                await viewModel.loadRecipes()
            }
            .refreshable { await refresh() }
    }
    // Load recipes after user manually refreshes list
    func refresh() async {
        await viewModel.loadRecipes()
    }
}

#Preview {
    ContentView()
}


