//
//  ThirdVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

class ThirdVC: TableTitleVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upaDataArr = ["UIWebView和js的交互","runtime方式测试全局tab添加无数据图案","9"]
        self.mainTable.reloadBlock = {() -> Void in
            self.upaDataArr = ["UIWebView和js的交互","runtime方式测试全局tab添加无数据图案 ","9"]
        };
       
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            do {
                
            }
            break
        case 1:
            do {
                //打开测试全局tab添加无数据图案 使用runtime方式，学习使用
                self.upaDataArr = NSArray.init();
            }
            break
        case 2:
            do {
                
            }
            break
        default:
            break
        }
      
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
