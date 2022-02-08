//
//  NetworkManager.swift
//  ChuckNorrisJokes
//
//  Created by Vanina Fileva on 25.10.20.
//

import Foundation

typealias GetCategoriesClosure = (_ categories: [String])->()
typealias GetJokeClosure = (_ joke: Joke) -> ()

protocol DataFetching {
    func getCategories(closure: @escaping GetCategoriesClosure)
    func getRandomJoke(in category: String?, closure: @escaping GetJokeClosure)
}



class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private var baseURLString: String {
        return "https://api.chucknorris.io/jokes/"
    }
}
extension NetworkManager: DataFetching {
    func getCategories(closure: @escaping GetCategoriesClosure) {
     
        // https://rapidapi.com/matchilling/api/chuck-norris
        guard let url = URL(string: baseURLString + "categories") else {
            return
        }

        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let data = data,
                  
                  let categories = try? JSONSerialization
                    .jsonObject(with: data, options: .allowFragments) as? [String] else {
                return
            }
           closure(categories)
        })

        task.resume()
    }
    
    func getRandomJoke(in category: String?, closure: @escaping GetJokeClosure) {
        guard let category = category,
              let url = URL(string: baseURLString + "random?category=\(category)") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data,
                  let joke = try? JSONDecoder().decode(Joke.self, from: data) else {
                return
            }
            closure(joke)
        })
        task.resume()
    }
}
