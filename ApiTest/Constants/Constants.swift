//
//  Constants.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 28/02/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation
import UIKit

let movieListCellIdentifire = "movieCell"
let MAX_WIDTH = UIScreen.main.bounds.size.width
func reloadTable(table:UITableView) {
    DispatchQueue.main.async {
        table.reloadData()
    }
}
