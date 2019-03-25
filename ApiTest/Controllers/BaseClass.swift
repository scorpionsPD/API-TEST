//
//  BaseClass.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 22/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class BaseClass: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        if location.y < MAX_HEIGHT - (MAX_HEIGHT - MAX_WIDTH) && self.children.count > 0 {
            removeChildViewFromController(self.children.last!, parent: self)
        }
    }
}
