//
//  NormalCell.swift
//  B7iOSBuyer
//
//  Created by 冯汉栩 on 2017/2/8.
//  Copyright © 2016年 com.spzjs.b7iosbuy. All rights reserved.
//

import UIKit

class SPBaseTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    separatorStyle = .none//隐藏分割线
    //不显示滚动条
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
