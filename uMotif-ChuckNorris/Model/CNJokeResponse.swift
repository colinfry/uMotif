//
//  CNJoke.swift
//  uMotif-ChuckNorris
//
//  Created by Colin Fry on 23/03/2022.
//

import Foundation

struct CNJoke: Identifiable, Codable, Equatable {
    var id: Int
    var joke: String
    var categories: [String]

    static let example = CNJoke(id: 365, joke: "Chuck Norris has never won an Academy Award for acting... because he's not acting.", categories: ["nerdy"])

    static func ==(lhs: CNJoke, rhs: CNJoke) -> Bool {
        lhs.id == rhs.id
    }
}

struct CNJokeResponse: Codable, Equatable {
    var status: String?
    var jokes: [CNJoke]?
    
    private enum CodingKeys: String, CodingKey {
        case status = "type"
        case jokes = "value"
    }

    static func ==(lhs: CNJokeResponse, rhs: CNJokeResponse) -> Bool {
        lhs.jokes == rhs.jokes
    }
}
