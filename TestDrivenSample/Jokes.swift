//
//  Jokes.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/04/26.
//

import Foundation

enum JokesAPI {
    case randomJokes

    static let baseURL = "https://api.icndb.com/"
//    var path: String
//    var url: String
}

enum APIError: LocalizedError {
    case unknownError
//    var errorDescription: String
}

class JokesAPIProvider {

//    let session: URLSession
//    init(session: URLSession = .shared) {
//        self.session = session
//    }
//
//    func fetchRandomJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
//        let request = URLRequest(url: JokesAPI.randomJokes.url)
//
//        let task: URLSessionDataTask = session
//            .dataTask(with: request) { data, urlResponse, error in
//                guard let response = urlResponse as? HTTPURLResponse,
//                      (200...399).contains(response.statusCode) else {
//                    completion(.failure(error ?? APIError.unknownError))
//                    return
//                }
//
//                if let data = data,
//                    let jokeResponse = try? JSONDecoder().decode(JokeReponse.self, from: data) {
//                    completion(.success(jokeResponse.value))
//                    return
//                }
//                completion(.failure(APIError.unknownError))
//        }
//
//        task.resume()
//    }
}
