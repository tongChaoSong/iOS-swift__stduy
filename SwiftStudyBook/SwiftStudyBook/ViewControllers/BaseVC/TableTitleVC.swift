//
//  TableTitleVC.swift
//  SwiftStudyMeans
//
//  Created by Apple on 2020/8/5.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TableTitleVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = (titleArr[indexPath.row] as! String)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleArr = ["1","2","3"]
        self.view.addSubview(mainTable)
        // Do any additional setup after loading the view.
    }
    
    lazy var mainTable:UITableView = {
        
        let table = UITableView.init(frame: CGRect.init(x: 0, y: kApplicationStatusBarHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: UITableView.Style.grouped)
        table.delegate = self;
        table.dataSource = self
        
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        return table
    }()
    
    var titleArr = Array<Any>.init()

    var upaDataArr:NSArray?{
        didSet{
            self.titleArr = upaDataArr as! [Any]
            self.mainTable.reloadData()
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
