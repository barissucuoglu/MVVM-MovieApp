//
//  MovieCell.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 27.12.2023.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    
    let movieImageView = MovieImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureMovieImageView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieImageView.downloadCancel()
    }
    
    
    func set(movie: MovieResult) {
        movieImageView.downloadImage(movie: movie)
    }
    
    
    private func configureMovieImageView() {
        addSubview(movieImageView)
        movieImageView.backgroundColor = .systemGray5
        movieImageView.pinToEdges(of: self)
    }
}
