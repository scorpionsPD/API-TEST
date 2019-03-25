//
//  CastingViewController.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 22/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class CastingViewController: UIViewController {
    
    var selectedMovieID: Int?
    var creditDataSource: CreditsDataSource?
    
    var creditsTableView:UITableView = {
        let table = UITableView()
        table.frame = CGRect(x: 0, y: -60, width: MAX_WIDTH, height: MAX_HEIGHT - (MAX_HEIGHT - MAX_WIDTH))
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        table.separatorStyle = .none
        
        table.register(CreditsTableViewCell.self, forCellReuseIdentifier: String(describing: CreditsTableViewCell.self))
        return table
    }()
    
    var background: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.gray
        image.frame = CGRect(x: 0, y: -60, width: MAX_WIDTH, height: MAX_HEIGHT+60)
        image.addBlurEffect()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.background)
        self.creditsTableView.backgroundColor = UIColor.clear
        self.view.addSubview(self.creditsTableView)
        addConstrints()
        RequestCreator.shared.callRequestForMoviesCredits(movieID: (selectedMovieID)!) { (credits) -> (Void) in
            self.creditDataSource = CreditsDataSource(credits: credits)
            DispatchQueue.main.async {
                self.creditsTableView.separatorStyle = .none
                self.creditsTableView.dataSource = self.creditDataSource
                reloadScrolableView(table: self.creditsTableView)
            }
        }
    }
    
    func addConstrints()  {
        
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
