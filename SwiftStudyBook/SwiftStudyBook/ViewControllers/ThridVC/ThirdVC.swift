//
//  ThirdVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit
class testmode{
    var subTitle: String = ""
}
class ThirdVC: TableTitleVC {

//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.upaDataArr = ["swift--struct、Class、enum、mutating","swift使用ocruntime的table默认图显示","关键字where、extension","struct深拷贝、Class浅拷贝"]
        self.mainTable.reloadBlock = {() -> Void in
            self.upaDataArr = ["swift--struct、Class、enum、mutating","swift使用ocruntime的table默认图显示","关键字where、extension、mutating"]
        };
       
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            do {
                claseStructEnumJump();
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
                let vc = KeywordsVC.init();
                vc.title = (self.upaDataArr![indexPath.row] as! String);
                self.navigationController?.pushViewController(vc, animated: true);
                
            }
            break
        case 3:
            do {
                var mo = testmode.init()
                mo.subTitle = "2444"
                print("dkjfkdjfkj=1==\(mo.subTitle)")
                var mo1:testmode = mo
                mo1.subTitle = "88888"
                print("dkjfkdjfkj=2==\(mo.subTitle)")
                withUnsafePointer(to: &mo) { ptr in
                    print("mo的指针地址===\(ptr)")
                }
                withUnsafePointer(to: &mo1) { ptr in
                    print("mo1的指针地址===\(ptr)")
                }
                
                
            }
            break
        default:
            break
        }
      
    }
    func claseStructEnumJump() -> Void {
//        ------------ eum
        //  常量student1值是 10
        let student1 = StudentType1.pupil.rawValue
        //  变量student2值是 15
        var student2 = StudentType1.middleSchoolStudent.rawValue
        //  使用成员rawValue属性创建一个`StudentType`枚举的新实例
        let student3 = StudentType1.init(rawValue: 15)
        //  student3的值是 Optional<Senson>.Type
        type(of: student3)
        //  student4的值是nil，因为并不能通过整数30得到一个StudentType实例的值
        let student4 = StudentType1.init(rawValue: 30)
//        -------------
        //student1 是一个StudentType类型的常量，其值为pupil（小学生），特征是"have fun"（总是在玩耍）
        let student5 = StudentType2.pupil("have fun")
        //student2 是一个StudentType类型的常量，其值为middleSchoolStudent（中学生），特征是 7, "always study"（一周7天总是在学习）
        let student6 = StudentType2.middleSchoolStudent(7, "always study")
        //student3 是一个StudentType类型的常量，其值为collegeStudent（大学生），特征是 7, "always LOL"（一周7天总是在撸啊撸）
        let student7 = StudentType2.middleSchoolStudent(7, "always LOL")
        switch student7 {
        case .pupil(let things):
            print("is a pupil and \(things)")
        case .middleSchoolStudent(let day, let things):
            print("is a middleSchoolStudent and \(day) days \(things)")
        case .collegeStudents(let day, let things):
            print("is a collegeStudent and \(day) days \(things)")
        }
        //        --------------- strut
        //使用Student类型的结构体创建Student类型的实例（变量或常量）并初始化三个成员（这个学生的成绩会不会太好了点）
        let student8 = Student3(chinese: 90, math: 80, english: 70)
        let student9 = Student4()
        var student10 = Student4(stringScore: "70,80,90")
        print("未改变了struct值 == student10 == \(student10.math)");
        student10.changeMath(num: 20);
        print("改变了struct值 == student10 == \(student10.math)");
        // -----------class
        //s1值会变动  复制指针
        var s1 = Person1()
        var s2 = s1
        s2.name = "mike"
//      //p1值不会变动  复制本体
        var p1 = People1()
        var p2 = p1
        p2.name = "mike"
        
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
