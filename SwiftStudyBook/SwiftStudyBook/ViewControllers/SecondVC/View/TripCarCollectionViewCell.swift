//
//  TripCarCollectionViewCell.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

class TripCarCollectionViewCell: UICollectionViewCell {
    
    
    
    lazy var headImage:UIImageView = {
        let imageV:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height / 4 * 3))
        imageV.backgroundColor = UIColor.purple
        return imageV
        }()
    lazy var mainTitle:UILabel = {
        let lab:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: headImage.frame.maxY, width: headImage.frame.width, height: self.frame.size.height / 4))
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.green
        lab.text = "欢乐购的券"
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headImage)
        self.addSubview(mainTitle)
       
    }
    
    func reloadDataObj() -> Void {
        headImage.frame.size.height = self.frame.size.height / 4 * 3
        mainTitle.frame.origin.y = headImage.frame.maxY
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
