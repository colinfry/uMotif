//
//  ContentViewModel.swift
//  uMotif-ChuckNorris
//
//  Created by Colin Fry on 23/03/2022.
//

import SwiftUI

enum VMState {
    case na
    case loading
    case success(data: [CNJoke]?)
    case fail(error: Error)
}

extension ContentView {
    
    @MainActor
    class ContentViewVM: ObservableObject {
        
        @Published var vmState: VMState = .na
        @Published var hasError: Bool = false
        
        private let cnJokesURL = "https://api.icndb.com/jokes/random/55?exclude=[explicit]"
        private let cnService = CNService()
        
        func loadModelData() async {
            
            vmState = .loading
            hasError = false
            
            do {
                let jokesResponse = try await cnService.fetchJokes(urlString: cnJokesURL)
                if let jokes = jokesResponse.jokes?.unique(selector: { $0.id == $1.id }) {
                    vmState = .success(data: jokes)
                } else {
                    throw ServiceError.failToDecode
                }
            } catch {
                vmState = .fail(error: error)
                hasError = true
            }
        }
    }
}

