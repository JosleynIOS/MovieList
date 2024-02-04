//
//  MainViewController.swift
//  MovieList
//
//  Created by Josleyn Santos on 2/1/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MainViewModel = MainViewModel()
    let cellIdentifier = "MainMovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
    }
    
    func setupViews() {
        self.title = "Movie List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.viewModel.getMovies()
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading ?? false {
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func navigateToMovieDetails(row: Int) {
        let detailsViewModel = viewModel.getDetailsViewModel(row: row)
        let detailsViewController = MovieDetailsViewController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MainMovieTableViewCell
        cell.setupDetails(viewModel: viewModel.getCellViewModel(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToMovieDetails(row: indexPath.row)
    }
}
