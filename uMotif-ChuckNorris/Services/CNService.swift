//
//  CNService.swift
//  uMotif-ChuckNorris
//
//  Created by Colin Fry on 23/03/2022.
//

import Foundation

enum ServiceError: Error {
    case fail
    case failNoURL
    case failToDecode
    case failStatusCode
}

struct CNService {
    
    func fetchJokes(urlString: String) async throws -> CNJokeResponse {
        
        guard let url = URL(string: urlString) else {
            throw ServiceError.failNoURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ServiceError.failStatusCode
        }
        
        let decodedData = try JSONDecoder().decode(CNJokeResponse.self, from: data)
        return decodedData
    }
}
