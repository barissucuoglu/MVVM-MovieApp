//
//  NetworkManager.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 28.12.2023.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    let cache = NSCache<NSString, UIImage>()
    
    
    @discardableResult
    func download(url: URL, completed: @escaping (Result<Data, AppError>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            completed(.success(data))
        }
        task.resume()
        
        return task
    }
}
