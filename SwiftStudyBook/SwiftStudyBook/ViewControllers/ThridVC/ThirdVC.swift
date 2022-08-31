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
//        self.upaDataArr = ["UIWebView和js的交互","8","9"]
        
        //打开测试全局tab添加无数据图案 使用runtime方式，学习使用
        self.upaDataArr = NSArray.init();

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
