//
//  FifthVC.swift
//  折上折
//
//  Created by apple on 2019/8/28.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit
class City: Codable {
    var errCode: String?
    var errMsg: String?
    var resCode: String?
    var resData:[String] = []
    //    var resData:NSDictionary = []
    //    var members: [Peson] = []
    //    var adog :Dog?
}

class Person: Codable {
    var name:String?
    
}
class Peson: Codable {
    var name: String?
    var age: Int?
    var address: String?
    var Person:Person?
    
    private enum CodingKeys:String,CodingKey{
        
        case name = "NAME"
        
        case age = "AGE"
        
        case address = "DOG"
        
        
    }
}
class FifthVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    let titleArr:NSArray = NSArray.init(objects: "历史出游人","我的好友","我的收藏","个人偏好","保险")
    let imageArr:NSArray = NSArray.init(objects: "icon_the visitors","icon_friend","icon_collectPerson","icon_pianhao","icon_insurance")
    
    let nameHead:UILabel = UILabel()
    let iamgeViewHead:UIImageView = UIImageView()
    let editBtnHead:UIButton = UIButton()
    let aitabiBtn:CityButton = CityButton()
    let aitabiNmber:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        loadData()
        // Do any additional setup after loading the view.
    }
    func createUI() -> Void {
        
        self.view.addSubview(mainTableView)
        //        self.view.addSubview(headNavView)
    }
    
    func loadData() -> Void {
//                    let netData:City = try! LsqDecoder.decode(City.self, param:data as! [String : Any])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    lazy var mainTableView:UITableView = {
        
        let table:UITableView = UITableView.init(frame: CGRect.init(x: 0, y: kApplicationStatusBarHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kApplicationStatusBarHeight - 50), style: UITableView.Style.grouped)
        table.delegate = self
        table.dataSource = self
        table.estimatedSectionFooterHeight = 0.0
        table.estimatedSectionHeaderHeight = 0.0
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        return table
        
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = titleArr[indexPath.row] as? String
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 16)
//        cell?.textLabel?.textColor = UIColor.red
        cell?.textLabel?.textColor = UIColor.getColor(hexColor: "0bb6a8")
        let name:String = imageArr[indexPath.row] as! String
        cell?.imageView?.image = UIImage.init(named: name)
        cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kApplicationStatusBarHeight + 202 + 119 ;
        //         return SCREEN_WIDTH * 252 / 375 + 119;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view = View(frame: UIScreen.main.bounds)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kApplicationStatusBarHeight + 202 + 119 ))
        headView.backgroundColor = UIColor.white
        
        
        //头像部分试图
        let headImage:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: headView.width, height: headView.height - 119))
        headImage.image = UIImage.init(named:"person_bg")
        headView .addSubview(headImage)
        
        //导航栏
        headView.addSubview(headNavView)
        
        //头像
        iamgeViewHead.frame = CGRect.init(x: 50, y:kApplicationStatusBarHeight + 15 , width: 45, height: 45)
        iamgeViewHead.image = UIImage.init(named: "mine_image_touxiang11")
        iamgeViewHead.isUserInteractionEnabled = true
        iamgeViewHead.layer.cornerRadius = 45/2;
        iamgeViewHead.layer.masksToBounds = true;
        headView.addSubview(iamgeViewHead)
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(headerImgTouch))
        iamgeViewHead.addGestureRecognizer(tap)
        
        //名字
        nameHead.frame = CGRect.init(x: iamgeViewHead.frame.maxX + 10, y: iamgeViewHead.frame.midY - 16 - 5, width: 200, height: 16)
        nameHead.textColor = UIColor.getColor(hexColor: "ffffff")
        nameHead.font = UIFont.systemFont(ofSize: 16)
        nameHead.text = "欢迎您"
        headView.addSubview(nameHead)
        
        //编辑
        editBtnHead.frame = CGRect.init(x:nameHead.x , y: iamgeViewHead.frame.midY + 5, width: nameHead.width, height: 12)
        editBtnHead.setTitle("点我登录账号 >", for: UIControl.State.normal)
        editBtnHead.setTitleColor(UIColor.getColor(hexColor: "ffffff").withAlphaComponent(0.8), for: UIControl.State.normal)
        editBtnHead.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        editBtnHead.addTarget(self, action: #selector(headerImgTouch), for: UIControl.Event.touchUpInside)
        editBtnHead.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        headView.addSubview(editBtnHead)
        
        //爱台币
        aitabiBtn.frame = CGRect.init(x:iamgeViewHead.x , y: iamgeViewHead.frame.maxY + 25, width: SCREEN_WIDTH - 100, height: 14)
        aitabiBtn.setTitle("爱沓币(个)", for: UIControl.State.normal)
        aitabiBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        aitabiBtn.setImage(UIImage.init(named: "btn_explainPeson"), for: UIControl.State.normal)
        aitabiBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        aitabiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        aitabiBtn.titleRect = CGRect.init(x: 0, y: 0, width:70, height: 14)
        aitabiBtn.imageRect = CGRect.init(x: 80, y: 0, width: 15, height: 15)
        aitabiBtn.addTarget(self, action: #selector(jumAiTaBi), for:UIControl.Event.touchUpInside)
        headView.addSubview(aitabiBtn)
        
        //aitabiNmber
        aitabiNmber.frame = CGRect.init(x:iamgeViewHead.x , y: aitabiBtn.frame.maxY + 25, width: SCREEN_WIDTH - 100, height: 30)
        aitabiNmber.textColor = UIColor.getColor(hexColor: "ffffff")
        aitabiNmber.font = UIFont.boldSystemFont(ofSize: 30)
        aitabiNmber.text = "0"
        
        headView.addSubview(aitabiNmber)
        //属性数据
        //        if ToolHelper.isLogin() {
        //            let userInfo:UserInfo = UserInfo.sharedInstance() as! UserInfo
        //            var name:NSString = userInfo.nickname! as NSString
        //
        //            if ConversionExtension.DYStringIsEmpty(value: name)
        //            {
        //                name = userInfo.userName! as NSString
        //            }
        //            iamgeViewHead.sd_setImage(with: NSURL.init(string:NSString(string: userInfo.handelImg) as String ) as URL?, placeholderImage: UIImage.init(named: "mine_image_touxiang11"), options: SDWebImageOptions.init(), completed: nil)
        //            nameHead.text = name as String
        //            editBtnHead.setTitle("查看并编辑个人资料 >", for: UIControl.State.normal)
        //
        //        }
        
        
        //下面三个按钮
        let bottomImage:UIImageView = UIImageView.init(frame: CGRect.init(x: 20, y: headImage.frame.maxY + 30, width: headView.width - 40, height: 50))
        bottomImage.isUserInteractionEnabled = true
        headView.addSubview(bottomImage)
        let persontile:NSArray = NSArray.init(objects: "我的行程","我的订单","我的旅记")
        let imagetile:NSArray = NSArray.init(objects: "icon_journey","icon_indent","icon_itinerary")
        let btnWid:CGFloat = bottomImage.width / CGFloat(persontile.count)
        let btnY:CGFloat = 0
        
        for (index,item) in persontile.enumerated() {
            
            let clickBtn:CityButton = CityButton.init(frame: CGRect.init(x: btnWid * CGFloat(index), y: btnY, width: btnWid, height: 50))
            clickBtn.tag = index;
            let imagStr:String = imagetile[index] as! String
            let titleStr:String = persontile[index] as! String
            
            clickBtn.setImage(UIImage.init(named: imagStr), for: UIControl.State.normal)
            clickBtn.setTitle(titleStr, for: UIControl.State.normal)
            clickBtn.titleLabel?.textAlignment = NSTextAlignment.center
            clickBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            clickBtn.setTitleColor(UIColor.getColor(hexColor: "333333"), for: UIControl.State.normal)
            let contentBtnImgW:CGFloat = 25
            
            clickBtn.imageRect = CGRect.init(x: (btnWid - contentBtnImgW) / CGFloat(2), y: 0, width: contentBtnImgW, height: contentBtnImgW)
            clickBtn.titleRect = CGRect.init(x: 0, y: contentBtnImgW+12.5, width:clickBtn.width , height: 14)
            clickBtn.addTarget(self, action: #selector(checkGroup(sender:)), for: UIControl.Event.touchUpInside)
            
            bottomImage.addSubview(clickBtn)
        }
        
        let linView:UIView = UIView.init(frame: CGRect.init(x: 0, y:headView.height - 10 , width: headView.width, height: 10))
        linView.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        headView .addSubview(linView)
        
        return headView
    }
    lazy var headNavView:UIView = {
        let head:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: kApplicationStatusBarHeight))
        head.backgroundColor = UIColor.clear
        
        let backBtn:UIButton = UIButton.init(frame: CGRect.init(x: 20, y: kApplicationStatusBarHeight - 44 + 20, width: 20, height: 25))
        backBtn.setImage(UIImage.init(named: "btn_back11"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(onClickBtnBack), for: UIControl.Event.touchUpInside)
        head.addSubview(backBtn)
        
        let setBtn:UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 20 - 25, y: backBtn.y, width: 24, height: 24))
        setBtn.setImage(UIImage.init(named: "btn_setting"), for: UIControl.State.normal)
        setBtn.addTarget(self, action: #selector(setBtnClick), for: UIControl.Event.touchUpInside)
        head.addSubview(setBtn)
        
        let messBtn:UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 20 - 24 - 25 - 24, y: backBtn.y, width: 24, height: 24))
        messBtn.setImage(UIImage.init(named: "btn_information"), for: UIControl.State.normal)
        messBtn.addTarget(self, action: #selector(messageTouch), for: UIControl.Event.touchUpInside)
        head.addSubview(messBtn)
        return head
        
    }()
    @objc func headerImgTouch() -> Void{
        
        
    }
    
    @objc func onClickBtnBack() -> Void {
        
    }
    
    @objc func setBtnClick() -> Void {
        //        if ToolHelper.isLogin(){
        //            let vc = MineSetVC.init()
        //            self.navigationController?.pushViewController(vc, animated: true)
        //
        //        }
        //        else
        //        {
        //            let vc = LoginViewController.init()
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
    }
    @objc func messageTouch() -> Void {
        //        if ToolHelper.isLogin(){
        //            let vc = MessageCenterVC.init()
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
        //        else
        //        {
        //            let vc = LoginViewController.init()
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
    }
    @objc func jumAiTaBi() -> Void{
        
        
        
    }
    @objc func checkGroup(sender:UIButton) -> Void {
        print("点击了 == \(sender.tag)")
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
