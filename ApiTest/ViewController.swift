//
//  ViewController.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 15/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit




class MovieListViewController: UITableViewController {
    
    var movieList:MovieList?
    
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
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: movieListCellIdentifire)
        
        RequestCreator.shared.callRequestForMoviesList(region: region.hollyWood.rawValue){(moviesList) in
            self.movieList = moviesList
            reloadScrolableView(table: self.tableView)
        }
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
            self.movieList = moviesList
            reloadScrolableView(table: self.tableView)
        }
    }
}

extension MovieListViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: movieListCellIdentifire) as! MovieTableViewCell
        cell.message = movieList?.results[indexPath.row].originalTitle
        NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: (movieList?.results[indexPath.row].posterPath)!), completion: { (imageContent) in
            DispatchQueue.main.async {
                 cell.mainImageView.image = imageContent
                
            }
        })
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.results.count ?? 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailView = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? MovieDetailsViewController{
            detailView.selectedMovie = movieList?.results[indexPath.row]
            
            self.navigationController?.pushViewController(detailView, animated: true)
        }
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
}
