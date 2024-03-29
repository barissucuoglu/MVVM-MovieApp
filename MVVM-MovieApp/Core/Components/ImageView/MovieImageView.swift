//
//  MovieImageView.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 27.12.2023.
//

import UIKit

final class MovieImageView: UIImageView {
    
    private var task: URLSessionTask?
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 16
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(movie: MovieResult) {
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else { return }
        let cacheKey = NSString(string: movie._posterPath)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        task = NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                
                cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async { self.image = image }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func downloadCancel() {
        task?.cancel()
        task = nil
    }
}
