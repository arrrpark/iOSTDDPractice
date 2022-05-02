//
//  ToDoItem.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/04/26.
//

import Foundation

struct JokeReponse: Decodable {
    let type: String
    let value: Joke
}

struct Joke: Decodable {
    let id: Int
    let joke: String
    let categories: [String]
}
