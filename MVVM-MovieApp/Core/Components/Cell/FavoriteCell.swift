//
//  FavoriteCell.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 29.12.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let movieImageView = MovieImageView(frame: .zero)
    let movieName = TitleLabel(textAlignment: .left, fontSize: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: MovieResult) {
        movieImageView.downloadImage(movie: favorite)
        movieName.text = favorite._title
    }
    
    private func configure() {
        addSubviews(movieImageView, movieName)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            movieImageView.widthAnchor.constraint(equalToConstant: 90),
            movieImageView.heightAnchor.constraint(equalToConstant: 90 * 1.5),
            
            movieName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 2 * padding),
            movieName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }
}
