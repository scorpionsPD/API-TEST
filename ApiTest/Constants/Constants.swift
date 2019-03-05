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
func reloadScrolableView(table:AnyObject) {
    
    
    DispatchQueue.main.async {
        table.reloadData()
    }
}

extension UIColor{
    class func transBlackColor() -> UIColor{
        return UIColor(red:0.0, green:0.0 ,blue:0.0 , alpha:0.3)
    }
}

extension UIFont{
    
    class func titleFont() -> UIFont{
        return UIFont.boldSystemFont(ofSize: 20.0)
    }
}
//nothing to commit
