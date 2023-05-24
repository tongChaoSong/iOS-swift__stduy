//
//  FourthVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

class FourthVC: TableTitleVC {
    var ory:Int = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        self.upaDataArr = ["圆角阴影共同存在","context上下文画布","3d筛子（CATransform3DRotate）","core Animation","setNeedsLayout，layoutIfNeeded","ui样式","无限制多级列表+设备方向测试 0 -1","设备方向测试"]
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
        case 5:
            do{
                let vc = UIStyleViewController.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 6:
            do{
                let vc = NodeTabVC.init()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case 7:
            do{
//                [self setNeedsUpdateOfSupportedInterfaceOrientations];
//                        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
//                        UIWindowScene *scene = [array firstObject];
//                        // 屏幕方向
//                        UIInterfaceOrientationMask orientation = isLaunchScreen ? UIInterfaceOrientationMaskLandscapeRight : UIInterfaceOrientationMaskPortrait;
//                        UIWindowSceneGeometryPreferencesIOS *geometryPreferencesIOS = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:orientation];
//                        // 开始切换
//                        [scene requestGeometryUpdateWithPreferences:geometryPreferencesIOS errorHandler:^(NSError * _Nonnull error) {
//                            NSLog(@"强制%@错误:%@", isLaunchScreen ? @"横屏" : @"竖屏", error);
//                        }];
                if #available(iOS 16.0, *) {
                    self.setNeedsUpdateOfSupportedInterfaceOrientations()
                    var sett:NSSet = UIApplication.shared.connectedScenes as NSSet;
                    var array:Array = sett.allObjects;
                    var scene:UIWindowScene = array.first as! UIWindowScene;
                    
                    
                } else {
                    // Fallback on earlier versions
                }
                
                if(ory == 0){
                    ory = 1
                    UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")

                }else if (ory == 1){
                    ory = 2
                    UIDevice.current.setValue(UIDeviceOrientation.portraitUpsideDown.rawValue, forKey: "orientation")

                }else if (ory == 2){
                    ory = 3
                    UIDevice.current.setValue(UIDeviceOrientation.landscapeLeft.rawValue, forKey: "orientation")

                }else if (ory == 3){
                    ory = 4
                    UIDevice.current.setValue(UIDeviceOrientation.landscapeRight.rawValue, forKey: "orientation")

                }else if (ory == 4){
                    ory = 0
                }
//                UIDeviceOrientationUnknown,                   // 未知方向，可能是设备(屏幕)斜置
//                    UIDeviceOrientationPortrait,                     // 设备(屏幕)直立
//                    UIDeviceOrientationPortraitUpsideDown,    // 设备(屏幕)直立，上下顛倒
//                    UIDeviceOrientationLandscapeLeft,           // 设备(屏幕)向左横置
//                    UIDeviceOrientationLandscapeRight,         // 设备(屏幕)向右橫置
//                    UIDeviceOrientationFaceUp,                     // 设备(屏幕)朝上平躺

//                UIDevice().setValue(UIDeviceOrientation.landscapeLeft, forKey: "orientation")
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
