//
//  GCDViewController.swift
//  SwiftStudyMeans
//
//  Created by Apple on 2020/8/5.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class GCDViewController: TableTitleVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.upaDataArr = ["GCD 任务和队列","8","9"]
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dsfklsflkjsklf\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            do{
                self.cgfserialToConCurrent()
            }
            break
        case 1:
            do{
                
            }
            break
        case 2:
            do{
                
            }
            break
        default:
            break
        }
    }
    func cgfserialToConCurrent() ->Void{
        
        //串行队列
        let serial = DispatchQueue(label: "serial",attributes: .init(rawValue:0))
        //并发队列
        let concurrent = DispatchQueue(label: "serial",attributes: .concurrent)
        //主队列
        let mainQueue = DispatchQueue.main
        //全局队列
        let global = DispatchQueue.global()
        let cureent = Thread.current
         
        print("当前线程 == \(cureent)")
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
