//
//  RatingView.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 19/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit
import UICircularProgressRing

class RatingView: UICircularProgressRing {

    var yValue: CGFloat = 0
    
    init() {
        super.init(frame: CGRect(x: MAX_WIDTH/3 + 5, y: MAX_WIDTH/2 + 70 - MAX_WIDTH/4 , width: MAX_WIDTH/7, height: MAX_WIDTH/7))
        self.backgroundColor = .clear
        self.outerRingColor = .black
        self.innerRingColor = .green
        self.outerRingWidth = 10
        self.innerRingWidth = 8
        self.maxValue = 10
        self.ringStyle = .ontop
        self.font = UIFont.boldSystemFont(ofSize: 10)
        self.fontColor = .white
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
    }
    
}


