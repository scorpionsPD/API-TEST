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
let MAX_HEIGHT = UIScreen.main.bounds.size.height

func reloadScrolableView(table:AnyObject) {
    DispatchQueue.main.async {
        table.reloadData()
    }
}

func adjustUITextViewHeight(arg : UITextView) {
    arg.translatesAutoresizingMaskIntoConstraints = true
    arg.sizeToFit()
    arg.isScrollEnabled = false
}
@available(iOS 12.0, *)
func adjusTableViewConstraints(arg: UITableView,relativeTo: AnyObject){
    UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: 7), animations: {
        arg.frame.origin.y+=relativeTo.frame.size.height
        arg.frame.size.height = MAX_HEIGHT - relativeTo.frame!.size.height - relativeTo.frame!.origin.x
    },completion: nil)
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

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

extension UILabel {
    
   class func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
}

func addChildViewToController(_ child: UIViewController , parent: UIViewController) {
    if parent.children.count > 0 {
        return
    }
    child.view.frame.origin.y = MAX_WIDTH
    parent.addChild(child)
    parent.view.addSubview(child.view)
    child.didMove(toParent: parent)
}
func removeChildViewFromController(_ child: UIViewController,parent: UIViewController){
    if parent.children.count > 0 {
        let viewControllers:[UIViewController] = parent.children
        for viewContoller in viewControllers{
            viewContoller.willMove(toParent: nil)
            viewContoller.view.removeFromSuperview()
            viewContoller.removeFromParent()
        }
    }
}
