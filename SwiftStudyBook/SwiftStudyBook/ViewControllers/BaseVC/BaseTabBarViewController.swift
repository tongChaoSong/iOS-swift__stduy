//
//  BaseTabBarViewController.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        // Do any additional setup after loading the view.
    }
    
    func createUI() -> Void {
        let titleArr = ["首页","oc","swift","ocui","个人"]
        let selectTitleArr = ["首页","OC","SWIFT","ocUI-","个人"]

        let homeVC = HomeVC()
        homeVC.navigationController?.title = "首页"
        
        let seconVC = SecondVC()
        
        let thirdVC = ThirdVC()
        
        let fourthVC = FourthVC()

        let fifthVC = FifthVC()

        let vcArr = [homeVC,seconVC,thirdVC,fourthVC,fifthVC]
    
        for (idex,basevc) in vcArr.enumerated() {
            let vc:BaseViewController = basevc
            let extractedExpr: BaseNavController = BaseNavController(rootViewController: vc)
            let baseNav:BaseNavController = extractedExpr
            self.addChild(baseNav)
            let title:String = titleArr[idex]
            let seletTitle:String = selectTitleArr[idex]
            baseNav.title = seletTitle
//            baseNav.navigationController.navigationBar.hidden = true;

            baseNav.hidesBottomBarWhenPushed = false
            baseNav.tabBarItem.title = title
            self.tabBar.selectedItem?.title = seletTitle
//            let noratt =  NSAttributedString.init(string: title,attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)]);
//
//            let selectatt = NSAttributedString.init(string: title,attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)]);
        
            baseNav.tabBarItem.image = UIImage.init(named: "icon_xiaoma");
            baseNav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)], for: .normal)
            baseNav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16)], for: .selected)



        }
        
        self.tabBar.backgroundColor = UIColor.white
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
