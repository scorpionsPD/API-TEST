//
//  ViewController.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 15/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit




class MovieListViewController: UITableViewController {
    
    var moviesListDataSource:HomeScreenDataSource?
    
    var industrySegment: UISegmentedControl = {
        let items = ["Hollywood","Bollywood"]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .lightGray
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = self.industrySegment
        industrySegment.addTarget(self, action: #selector(self.selectedSegment(_:)), for: .valueChanged)
        
        let nib = UINib.init(nibName: String(describing: MovieListTableViewCell.self), bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        
        RequestCreator.shared.callRequestForMoviesList(region: region.hollyWood.rawValue){(moviesList) in
            DispatchQueue.main.sync {
                self.moviesListDataSource = HomeScreenDataSource(movieList: moviesList)
                self.tableView.dataSource = self.moviesListDataSource
                reloadScrolableView(table: self.tableView)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func selectedSegment(_ sender: UISegmentedControl) {
        
        var selectedRegion:String?
        switch sender.selectedSegmentIndex{
        case 0:
            selectedRegion = region.hollyWood.rawValue
        case 1:
            selectedRegion = region.bollyWood.rawValue
        default:
            break
        }
        RequestCreator.shared.callRequestForMoviesList(region: selectedRegion!){(moviesList) in
            DispatchQueue.main.sync {
                self.moviesListDataSource = HomeScreenDataSource(movieList: moviesList)
                self.tableView.dataSource = self.moviesListDataSource
                self.tableView.delegate = self
                reloadScrolableView(table: self.tableView)
            }
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: String(describing: MovieDetailsViewController.self))) as? MovieDetailsViewController{
            detailVC.selectedMovie = self.moviesListDataSource?.movieArray[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
