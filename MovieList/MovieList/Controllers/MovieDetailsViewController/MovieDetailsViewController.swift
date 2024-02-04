//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/5/24.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    func setupViews() {
        self.title = "Movie Details"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        self.titleLabel.text = viewModel.movieTitle
        self.descriptionLabel.text = viewModel.movieDescription
        
        self.imageView.kf.setImage(with: viewModel.movieImageURL, placeholder: UIImage(named: "movie_placeholder"))
    }
    
    func fixAndValidateURL(_ urlString: String) -> URL? {
        // Check if the URL string is empty or contains only whitespaces
        guard !urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }

        // Check if the URL string has a valid scheme (e.g., http, https)
        if URL(string: urlString) == nil {
            // If not, try to add a default scheme (e.g., https)
            let fixedURLString = "https://" + urlString
            return URL(string: fixedURLString)
        }

        // URL is valid, return the original URL
        return URL(string: urlString)
    }

}
