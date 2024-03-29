//
//  MovieService.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 25.12.2023.
//

import Foundation

class MovieService {
    
    func downloadMovies(page: Int, completed: @escaping ([MovieResult]?) -> Void) {
        guard let url = URL(string: APIURLs.movies(page: page)) else { return }
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let data):
                completed(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    
    func downloadDetail(id: Int, completed: @escaping(MovieResult?) -> Void) {
        guard let url = URL(string: APIURLs.detail(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completed(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
    private func handleWithData(_ data: Data) -> [MovieResult]? {
        let decoder = JSONDecoder()
        
        do {
            let movie = try decoder.decode(Movie.self, from: data)
            return movie.results
        } catch {
            print(AppError.unableToComplete)
            return nil
        }
    }
    
    
    private func handleWithData(_ data: Data) -> MovieResult? {
        let decoder = JSONDecoder()
        
        do {
            let movieDetail = try decoder.decode(MovieResult.self, from: data)
            return movieDetail
        } catch {
            print(AppError.unableToComplete)
            return nil
        }
    }
}

