//
//  BaseViewController.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit
import Foundation

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        LoadBaseUI()
        // Do any additional setup after loading the view.
    }
    
    func LoadBaseUI() -> Void {
        self.view.backgroundColor = UIColor.white
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
