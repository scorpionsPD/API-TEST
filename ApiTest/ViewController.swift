//
//  ViewController.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 15/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit




class MovieListViewController: UITableViewController {
    //var modal:DataModal?
    var movieList:MovieList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: movieListCellIdentifire)
        
        RequestCreator.shared.callRequestForMoviesList(){(moviesList) in
            self.movieList = moviesList
            reloadTable(table: self.tableView)
            //self.tableView.layoutSubviews()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension MovieListViewController{
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: movieListCellIdentifire) as! MovieTableViewCell
        cell.message = movieList?.results[indexPath.row].originalTitle
        NetworkHandler.sharedInstance.downloadImage(from: posterURL(posterPath: (movieList?.results[indexPath.row].posterPath)!), completion: { (imageContent) in
            cell.mainImageView.image = imageContent
        })
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.results.count ?? 0
    }
    
}
