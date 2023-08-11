//
//  NormalCell.swift
//  B7iOSBuyer
//
//  Created by 冯汉栩 on 2017/2/8.
//  Copyright © 2016年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

class SPTableViewCell: UITableViewCell,SPCellProtocol {

    override func awakeFromNib() {
        super.awakeFromNib()
      selectionStyle = .none
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
