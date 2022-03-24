//
//  ContentViewModel.swift
//  uMotif-ChuckNorris
//
//  Created by Colin Fry on 23/03/2022.
//

import SwiftUI

extension ContentView {
    @MainActor
    class ContentViewVM: ObservableObject {
        
        @Published var jokes: [CNJoke]?
        
        private let cnJokesURL = "https://api.icndb.com/jokes/random/55?exclude=[explicit]"
        private let cnService = CNService()
        
        init() {
            loadModelData()
        }
        
        private func loadModelData() {
            Task {
                if let jokesResponse = try? await cnService.fetchJokes(urlString: cnJokesURL) {
                    jokes = jokesResponse.jokes?.unique{ $0.id == $1.id }
                } else {
                    // Error handling to be added here
                    jokes = []
                }
            }
        }
    }
}

