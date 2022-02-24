//
//  FourthVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

class FourthVC: TableTitleVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.upaDataArr = ["圆角阴影共同存在","context上下文画布","3d筛子（CATransform3DRotate）","core Animation","setNeedsLayout，layoutIfNeeded"]
        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            do{
                let vc = CorShaVViewController.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 1:
            do{
                let vc = LayerViewController.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 2:
            do{
                let vc = Transfoem3DVC.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
            
        case 3:
            do{
                let vc = CoreAnimationVC.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 4:
            do{
                let vc = LayIfneedViewController.init()
                self.navigationController?.pushViewController(vc, animated: true)
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
