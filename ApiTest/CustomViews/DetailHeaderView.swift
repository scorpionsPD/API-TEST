//
//  DetailHeaderView.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 05/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var bannerView: UIImageView = {
        let baner = UIImageView()
        baner.backgroundColor = UIColor.gray
        //baner.autoSetDimension(.height, toSize: MAX_WIDTH / 3)
        return baner
        
        
    }()
    var profileView: UIImageView = {
        let profile = UIImageView()
        profile.backgroundColor = UIColor.yellow
        profile.frame = CGRect(x: 5, y: (MAX_WIDTH - (MAX_WIDTH / 3) + (MAX_WIDTH / 3) / 2), width: MAX_WIDTH / 3, height: MAX_WIDTH / 3)
        return profile
    }()
    
    var segmentedControl: UISegmentedControl = {
        let segments = UISegmentedControl(items: ["Tweets", "Media", "Likes"])
        return segments
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.addSubview(bannerView)
        self.addSubview(profileView)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
