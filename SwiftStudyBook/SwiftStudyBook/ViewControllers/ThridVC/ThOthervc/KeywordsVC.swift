//
//  KeywordsVC.swift
//  SwiftStudyBook
//
//  Created by 1998xxsq on 2023/5/25.
//  Copyright © 2023 tcs. All rights reserved.
//

import UIKit
protocol MyProtocol {
    func getNameMethod()
}
class Cat : MyProtocol{
    func getNameMethod() {
        
    }
}
class Dog1{
    
}
//Cat 添加了协议才能添加拓展
extension MyProtocol where Self :Cat{
    func showName(){
        print("Cat")
    }
}
//Dog 没添加协议不能能添加拓展
extension MyProtocol where Self :Dog1{
    func showName(){
        print("Dog")
    }
}

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

class KeywordsVC: TableTitleVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.upaDataArr = ["where","extension","添加计算属性 - computed properties"]
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            do {
                wherekeybord()
            }
            break
        case 1:
            do {
                
            }
            break
        case 2:
            do {
                
                
            }
            break
        case 3:
            do {
                // usage of Double extension
                let oneInch = 25.4.mm
                print("One inch is \(oneInch) meters")
                // Prints "One inch is 0.0254 meters"
                let threeFeet = 3.ft
                print("Three feet is \(threeFeet) meters")
                // Prints "Three feet is 0.914399970739201 meters"
                let aMarathon = 42.km + 195.m
                print("A marathon is \(aMarathon) meters long")
                // Prints "A marathon is 42195.0 meters long"
            }
            break
        case 4:
            do {
                
                
            }
            break
        default:
            break
        }
      
    }
    
    func wherekeybord() -> Void {
        let datas = [1,2,3,4,5,6,7,8,9,10]
        for item in datas where item > 4 {
            print(item)
        }
        
        
        let dog = Dog1()//没继承协议 没有拓展方法
        let cat = Cat()//继承了协议 有拓展方法
        cat.showName()
    
        setValue(item: ["12345","223444","344444","41334"])
//        setValue(item: ["12345","223444","344444","41334","2134"])

    }

//    func setValue(item : [String]?) {
//        guard let item = item where item.count > 4 else { return }
//    }
    //        Swift 4.0以后使用逗号代替where
    func setValue(item : [String]?) {
        guard let item = item, item.count > 4 else {
            print("nononono")
            return
            
        }
        print("yyyyyyyyy")
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
