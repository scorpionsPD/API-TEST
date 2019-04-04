//
//  HomeScreenVC.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 01/04/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    @IBOutlet weak var listingTableView: UITableView!
    var moviesListDataSource:HomeScreenDataSource?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: String(describing: MovieListTableViewCell.self), bundle: nil)
        self.listingTableView.register(nib, forCellReuseIdentifier: String(describing: MovieListTableViewCell.self))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        RequestCreator.shared.callRequestForMoviesList(region: region.hollyWood.rawValue){(moviesList) in
            DispatchQueue.main.sync {
                self.moviesListDataSource = HomeScreenDataSource(movieList: moviesList)
                self.listingTableView.dataSource = self.moviesListDataSource
                DispatchQueue.main.async {
                    self.listingTableView.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension HomeScreenDataSource: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.movieArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieListTableViewCell.self)) as! MovieListTableViewCell
//        cell.item = movieArray[indexPath.row]
//        return cell
//    }
//}
