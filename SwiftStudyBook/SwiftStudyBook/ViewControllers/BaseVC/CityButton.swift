//
//  CityButton.swift
//  SwiftStudyMeans
//
//  Created by apple on 2020/7/27.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class CityButton: UIButton {

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if (self.titleRect != nil){
            
            return titleRect!
        }
        
        return super.titleRect(forContentRect: contentRect)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if (self.imageRect != nil){
            
            return imageRect!
        }
        return super.imageRect(forContentRect: contentRect)
    }
    public var titleRect:CGRect?
//    {
//        get {
//            return self.titleRect
//        }
//        set(newLeft) {
//            if newLeft.isEmpty || newLeft.equalTo(self.titleRect) {
//
//            }
////            var frame = self.frame
////            frame.origin.x = newLeft
////            self.frame = frame
//        }
//    }
//
    public var imageRect:CGRect?
//    {
//           get {
//               return self.frame.origin.x
//           }
//           set(newLeft) {
//               var frame = self.frame
//               frame.origin.x = newLeft
//               self.frame = frame
//           }
//       }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
