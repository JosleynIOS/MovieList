//
//  MainMovieTableViewCell.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/4/24.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.descriptionLabel.isHidden = false
    }
    
    func setupDetails(viewModel: MainMovieCellViewModel) {
        self.titleLabel.text = viewModel.movieTitle
        if viewModel.shouldShowDescription {
            self.descriptionLabel.text = viewModel.movieDescription
        } else {
            self.descriptionLabel.isHidden = true
        }
    }
}
