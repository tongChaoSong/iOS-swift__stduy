//
//  TCSTabPlaceholderView.swift
//  SwiftStudyBook
//
//  Created by TCS on 2022/8/31.
//  Copyright © 2022 tcs. All rights reserved.
//

import UIKit

typealias KeyBordClickBlock = (_ message:String)->(Void)


class TCSTabPlaceholderView: UIView {
    
   
    @objc var keyBordClick:KeyBordClickBlock!

    override init(frame: CGRect) {
         super.init(frame: frame)
            
        createUI()
    }
    
    func createUI() -> Void{
        let btnWid:CGFloat = self.width
        let btnHg:CGFloat = self.height

        let sureBtn:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnWid, height: btnHg))
        sureBtn.setTitle("确定", for: UIControl.State.normal)
        sureBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sureBtn.addTarget(self, action: #selector(sureClick), for: UIControl.Event.touchUpInside)
        sureBtn.backgroundColor = UIColor.red
        self.addSubview(sureBtn)
    }
    
    @objc func sureClick() -> Void {
        if self.keyBordClick != nil{
            self.keyBordClick("点击事件")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
