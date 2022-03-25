//
//  ContentView.swift
//  uMotif-ChuckNorris
//
//  Created by Colin Fry on 22/03/2022.
//

/*
 In a less trivial application we may want to add an enum to manage app/view state and app flow.
    Loading - checking internet connection, api calls etc, loading indicator
    Success - display view
    Failure - display error message(s)
 
 ContentView would more likely provide a wrapper for a number of entry points into the app - login, sign up etc - so common data models could be passed to child Views/ViewModels as @environmentObject.
 */

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewVM
        
    init() {
        _viewModel = StateObject(wrappedValue: ContentViewVM())
    }
    
    var body: some View {        
        NavigationView {
            List {
                switch viewModel.vmState {
                    
                case .loading:
                    Text("Loading jokes")
                case .success(let data):
                    if data != nil {
                        ForEach(data!, id: \.id) { joke in
                            Text(joke.joke)
                                .font(.body)
                                .padding(5)
                        }
                    } else {
                        Text("It's no joke!")
                    }
                default:
                    Text("It's no joke! There's been an error")
                }
            }
            .navigationTitle("55 Terrible Jokes")
        }
        .task {
            await viewModel.loadModelData()
        }
        .alert("Error",
               isPresented: $viewModel.hasError,
               presenting: viewModel.vmState) { detail in
            
            Button("Retry") {
                Task {
                    await viewModel.loadModelData()
                }
            }
        } message: { detail in
            if case let .fail(error) = detail {
                Text(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
