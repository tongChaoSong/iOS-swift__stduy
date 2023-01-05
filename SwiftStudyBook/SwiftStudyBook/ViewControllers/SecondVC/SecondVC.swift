//
//  SecondVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit
import CloudKit
class SecondVC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,PuBuLiuCustFlowLayoutDelegate {
    
    
    
    lazy var mainColletion:UICollectionView = {
        
//        let flowly:PuBuLiuCustFlowLayout = PuBuLiuCustFlowLayout()
        // 设置网格的大小
//        let flowly:UICollectionViewFlowLayout = UICollectionViewFlowLayout()

//        flowly.itemSize = CGSize(width:SCREEN_WIDTH/2 - 15 , height: 100)
        
        let flowly:PuBuLiuLay = PuBuLiuLay()

        flowly.itemSize = CGSize(width:(SCREEN_WIDTH - 30)/2  , height: 100)

        flowly.delegate = self
        //设置最小行间距
        
        flowly.minimumLineSpacing = 10
        
        //设置最小列间距
        
        flowly.minimumInteritemSpacing = 10
        
        //设置分区缩进量
        
        flowly.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        // 设置滚动方向
        
        flowly.scrollDirection = UICollectionView.ScrollDirection.vertical
        

        let colletion:UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: flowly)
        
        colletion.delegate = self
        colletion.dataSource = self
        colletion.backgroundColor = UIColor.white
        
        colletion.register(TripCarCollectionViewCell.self, forCellWithReuseIdentifier: "TripCarCollectionViewCell")
        
        colletion.register(UIView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        //UICollectionElementKindSectionHeader
        //        elementKindSectionHeader
        colletion.addInfiniteScrolling {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2) {
                colletion.infiniteScrollingView.stopAnimating()
            }
        }
        colletion.addPullToRefresh {
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2) {

                colletion.infiniteScrollingView.stopAnimating()
            }
        }
        return colletion
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        createUI()
        // Do any additional setup after loading the view.
    }
    
    func createUI() -> Void {
    
        self.view.addSubview(self.mainColletion)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return titleArr.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:TripCarCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripCarCollectionViewCell", for: indexPath) as! TripCarCollectionViewCell
        cell.reloadDataObj()
        cell.mainTitle.text = titleArr[indexPath.row]
        cell.backgroundColor = UIColor.red
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击是的section = \(indexPath.section) row = \(indexPath.row)")

        switch indexPath.row {
        case 0:
            do{
                let vc = GCDViewController()
                self.navigationController!.pushViewController(vc, animated: true)
            }
            break
            
            
            
        case 1:
            do{
                let vc = weakStudyVC()
                self.navigationController!.pushViewController(vc, animated: true)
            }
            break
            
        case 2:
            do{
                let vc = RuntimeViewController()
                self.navigationController!.pushViewController(vc, animated: true)
            }
            break
            
        case 3:
            do{
                let vc = RunloopViewController()
                self.navigationController!.pushViewController(vc, animated: true)
            }
            break
        case 4:
            do{
                let vc = BlockViewController()
                self.navigationController!.pushViewController(vc, animated: true)
            }
            break
        case 5:
            do{
                var dict:Dictionary<String,String> = [:]
                var dict3: Dictionary<String, String> = [:]
                let dict1 = ["zhangsan": 18, "lisi": 19]
                ToolClass.createPropetyCode(dict1);
            }
            break
            
            
        default:
            let vc:SecondDetailVC = SecondDetailVC()
            self.navigationController!.pushViewController(vc, animated: true)
            break
        }
                       
    }
    //设置headview高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: SCREEN_WIDTH, height: 20)
        
    }
    //设置headview
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview:UICollectionReusableView!
        
        if kind == UICollectionView.elementKindSectionHeader{
            
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            reusableview.backgroundColor = UIColor.red
        }
        return reusableview
        

    }

    
    func hw_SetCellHeight(layout: PuBuLiuLay, index: NSIndexPath, itemWidth: CGFloat) -> CGFloat {

//        let count:UInt32 = UInt32(titleArr.count)
        
        let i = arc4random() % 4
        if i == 1{
            return 150
        }else if i == 2{
            return 160
        }else if i == 3{
            return 100
        }else{
            return 180
        }
       
    }
    
    let titleArr = ["swift-GCD","weak","runtime","runloop、类簇","block","自动生成后台返回dict属性"]
    
    let titleArr2 = ["swift-GCD","weak","runtime","runloop、类簇","block","自动生成后台返回dict属性"]
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
