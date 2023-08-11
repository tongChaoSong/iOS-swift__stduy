//
//  HomeVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {

    var nameStr:String?{
        get{
            return self.nameStr
        }
        set{
            self.nameStr = newValue
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.purple
        // Do any additional setup after loading the view.
    
        let txt:TextField = TextField.init(frame: CGRect.init(x: 0, y: kApplicationStatusBarHeight, width: SCREEN_WIDTH, height: kApplicationStatusBarHeight))
//        txt.wordLimit = 10
        txt.backgroundColor = Color.assist
        self.view.addSubview(txt)
        loadData()
//        self.upaDataArr = ["struct、Class、enum","runtime方式测试全局tab添加无数据图案","9"];

//        testData()
    }
    
    func loadData() -> Void {
        let jsonString =
        """
    {
        "name":"技术部",
        "id":123,
        "members":[
            {
                "NAME":"xiaoming",
                "AGE":24,
                "ADDRESS":"nanjing",
                "dog":{
                    "name":"Tom"
                }
            },
            {
                "NAME":"LOLITA0164",
                "AGE":26,
                "ADDRESS":"nanjing",
                "dog":{
                    "name":"Tonny"
                }
            },
        ],
        "manager":{
            "NAME":"ZHANG",
            "AGE":33,
            "ADDRESS":"nanjing",
        }
    }
    """
        
        if let jsonData = jsonString.data(using: String.Encoding.utf8) {
            if let group:Department = try? JSONDecoder().decode(Department.self, from: jsonData) {
                print("groupgroup==\(group)");
                dump(group)
            }
        }
    }

    func testData()->Void{
        var me = (name:"sad",age:12,email:"dlksjfkldjs")
        me.name = "skkjf"
        me.age = 12
        
        var number = [1,2,3,4]
        number.swapAt(0, 3)
        print("number == \(number)")
        
        let name = ["aAl","Jj","bq","bj"]
        
        //简单说就是可以对数组中的元素格式进行转换，最后返回一个新的数组。
//        let otoot1 = name.map { (ssss) -> T in
////            T  代表任何类型
//           return "\(ssss) fskjf"
//        }
        let mapArr = name.map { (ssss) -> String in
            print("map == \(ssss)")
            return "\(ssss) fskjf"
        }
        print("otoot == \(mapArr)")
        
        let filterMapArr = ["1","","3","4","","6"]
        let filterMap = filterMapArr.flatMap { (tttt) -> String in
            
            return tttt
        }
        print("filterMap == \(filterMap)")
        
        let filter = [1,2,3,4,7]
        let filterArr = filter.filter { (data) -> Bool in
            
            if data > 3{
                return true
            }else{
                return false
            }
        }
        print("filterArr == \(filterArr)")

//        let othertype:[(Int,String)] = [1,2,3,4,7,"aini"]
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
