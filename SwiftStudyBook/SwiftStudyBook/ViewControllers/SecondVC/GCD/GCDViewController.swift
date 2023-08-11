//
//  GCDViewController.swift
//  SwiftStudyMeans
//  https://www.jianshu.com/p/2b46e5f91743 引用
//  Created by Apple on 2020/8/5.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import CoreData

class GCDViewController: TableTitleVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.upaDataArr = ["GCD 任务和队列-0","死锁-1","主队列+异步任务-2","串行队列+同步任务(不在主线程)-3","串行队列+异步任务-4","并发队列+同步任务-5","并发队列+异步任务（最大并发数64)-6","GCD 栅栏-7","GCD group-8","信号量 semaphore-9","延时任务-10","DispatchWorkItem-11","线程常驻","总揽打开多线程编程文档"]
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("当前那个---\(indexPath) 标题是--\(self.upaDataArr![indexPath.row])")
        switch indexPath.row {
        case 0:
            do{
                self.gcdserialToConCurrent()
            }
            break
        case 1:
            do{
                self.dealLock()
            }
            break
        case 2:
            do{
                mainAsync()
            }
            break
        case 3:
            do{
                serialSync()
            }
            break
        case 4:
            do{
                serialAsync()
            }
            break
        case 5:
            do{
                cocurrentSync()
            }
            break
        case 6:
            do{
                cocurrentAsync()
            }
            break
        case 7:
            do{
                dispatchWork()
            }
            break
        case 8:
            do{
                gcdGroup()
            }
            break
        case 9:
            do{
                semaphorsNumber()
            }
            break
            
        case 10:
            do{
                dispacthAfter()
            }
            break
        case 11:
            do{
                gcdDispatchWorkItem()
            }
            break
        case 12:
            do{
                longThread()
            }
        default:
            break
        }
    }
    //队列的获取与创建
    func gcdserialToConCurrent() ->Void{
        /**
         
            GCD队列都遵循先进先出（FIFO）。所以往并发队列中添加同步任务，其执行顺序和任务的添加顺序相同。全局队列在功能上和并发队列是等价的，所以需要并发队列时，首选使用系统的全局队列。

         */
        //串行队列
        let serial = DispatchQueue(label: "serial")
        //并发队列
        let concurrent = DispatchQueue(label: "concurrent",attributes: .concurrent)
        //主队列
        let mainQueue = DispatchQueue.main
        //全局队列
        let global = DispatchQueue.global()
        currentTreadLog()
    }
    //死锁
    func dealLock() ->Void{
        /**
         
         主线程同步导致死锁
         在同一串行队列中，开启线程同步，导致死锁
         
         */
//        print(1)
//        DispatchQueue.main.sync {
//            print(2)
//        }
//        print(3)
        
        print(4)
        let serialq = DispatchQueue(label: "serial",attributes: .init(rawValue:0))
        serialq.async {
             print(5)
            serialq.sync {
                print(6)
            }
            print(7)
        }
        print(8)
    }
    
//    主队列+异步任务
    func mainAsync () -> Void{
        /**
         不开启新线程
         */
        print("1 -- \(self.currentTreadLog())")
        DispatchQueue.main.async {
            print("2 -- \(self.currentTreadLog())")

        }
        print("3 -- \(self.currentTreadLog())")
    }
//  串行队列+同步任务
    func serialSync () -> Void{
        /**
         依次执行
         */
        let serial = DispatchQueue(label: "serial",attributes: .init(rawValue:0))
        for i in 0...10 {
            serial.sync {
                sleep(arc4random()%3)//休眠时间随机
                print("串行队列+同步任务 --- \(i) --\(self.currentTreadLog())")
            }
        }
    }
//    串行队列+异步任务
    func serialAsync () ->Void{
        /**
         开启一个新线程依次执行
         */

        let serial = DispatchQueue(label: "serial",attributes: .init(rawValue:0))
        print(Thread.current)//主线程
        for i in 0...10 {
            serial.async {
                sleep(arc4random()%3)//休眠时间随机//子线程
                print("串行队列+异步任务 --- \(i) --\(self.currentTreadLog())")
            }
        }
    }
    // 并发+同步
    func cocurrentSync () ->Void{
        let concurrent = DispatchQueue(label: "concurrent",attributes: .concurrent)

        for i in 0...10{
            concurrent.sync {
                sleep(arc4random()%3)//休眠时间随机//子线程
                print("并发+同步 --- \(i) --\(self.currentTreadLog())")
            }
        }
    }
    // 并发+异步
    func cocurrentAsync () ->Void{
        let concurrent = DispatchQueue(label: "concurrent",attributes: .concurrent)

        for i in 0...10{
            concurrent.async {
                sleep(arc4random()%3)//休眠时间随机//子线程
                print("并发+异步 --- \(i) --\(self.currentTreadLog())")
            }
        }
        
        //最大并发数量
//        for i in 0...1000 {
//            DispatchQueue.global().async {
//                 print("并发+异步 --- \(i) --\(self.currentTreadLog())")
//                sleep(10000)
//            }
//        }
    }
    
    //GCD 栅栏
    func dispatchWork() ->Void{
        /**
         在swift中栅栏不再是一个单独的方法。而是DispatchWorkItemFlags结构体中的一个属性。sync/async方法的其中一个参数类型即为DispatchWorkItemFlags，所以使用代码如下。这样的调用方式可以更好的理解栅栏，其实它就是一个分隔任务，将其添加到需要栅栏的队列中，以分隔添加前后的其他任务。以下代码栅栏前后均为并发执行。如果将添加栅栏修改为sync则会阻塞当前线程。

         
         */
        
        //数据库的多读 单写可使用栅栏方式（读之前用异步，写用栅栏写入数据）
//        let concurrent = DispatchQueue(label: "concurrent",attributes: .concurrent)

        
        for i in 0...10 {
            DispatchQueue.global().async {
                print("DispatchWorkItemFlags -前- \(i)")
            }
        }
        DispatchQueue.global().async(flags: .barrier) {
            print("this is barrier")
        }
        
        
        for i in 11...20 {
            DispatchQueue.global().async {
                print("DispatchWorkItemFlags -后- \(i)")
            }
        }
    }
    
    //线程组 gcd Group
    func gcdGroup() ->Void{
        /**
         队列组一般用来处理任务的依赖，比如需要等待多个网络请求返回后才能继续执行后续任务。

         使用notify添加结束任务

         必须要等待group中的任务执行完成后才能执行，无法定义超时。
         */
        
        let group = DispatchGroup()
        for i in 0...10 {
            DispatchQueue.global().async(group: group) {
                sleep(arc4random()%3)//休眠时间随机
                print("gcd Group --\(i) --\(self.currentTreadLog())")
            }
        }
        //queue参数表示以下任务添加到的队列
        group.notify(queue: DispatchQueue.main) {
            print("group 任务执行结束")
        }
       //使用wait进行等待——可定义超时
        switch group.wait(timeout: DispatchTime.now()+5) {
        case .success:
            print("group 任务执行结束")
        case .timedOut:
            print("group 任务执行超时")
        }
        
        /**
         enter()是标示一个任务加入到队列，leave()标识一个队列中的任务执行完成。
         注意：enter()与leave()必须成对调用。
         如果enter()后未调用leave()则不会触发notify，wait也只会timeout。
         如果leave()之前没有调用enter()则会引起crash。
         */
        

        //用于网络请求前 进入 group.enter() 请求结果拿到后，处理完数据后 离开 group.leave()
        group.enter()
        group.leave()
    }
    
//    信号量 semaphore
    func semaphorsNumber() -> Void{
        /**
         GCD 中的信号量是指 Dispatch Semaphore，是持有计数的信号。类似于过高速路收费站的栏杆。可以通过时，打开栏杆，不可以通过时，关闭栏杆。在 Dispatch Semaphore 中，使用计数来完成这个功能，计数为0时等待，不可通过。计数为1或大于1时，计数减1且不等待，可通过。
         
         // semaphore.wait()
         // 如果信号量的值>0，就减1，然后往下执行后面的代码
         // 如果信号量的值<=0，当前线程就会进入休眠等待，直到信号量的值>0
         
         // semaphore.signal()
         // 让信号量的值增加1，信号量值不等于零时，前面的等待的代码会执行
         */
        
        let semaphore = DispatchSemaphore(value: 1)//创建一个信号量，并初始化信号总量
//        semaphore.signal()//发送一个信号让信号量加1
        let concurrent = DispatchQueue(label: "concurrent",attributes: .concurrent)
        
        let serial = DispatchQueue(label: "serial",attributes: .init(rawValue:0))
        
        
        concurrent.async {
             print("concurrent.async -0")
            semaphore.wait()
            print("concurrent.async -1")
            //休眠1秒  保证数据正常打印
//            sleep(1)
            semaphore.signal()
            print("concurrent.async -2")
        }
        print("concurrent.async - 3")
//        semaphore.wait()
        print("concurrent.async - 4")
        
        //休眠2秒 保证测试完成，信号量不等0，否则会阻塞主线程，导致程序crash
//        sleep(2)
//        concurrent.sync {
//
//            print("concurrent.sync")
//        }
//        serial.async {
//            print("serial.async")
//        }
//        serial.sync {
//            print("serial.sync")
//        }
//        print("开始了")
//        for i in 0...10{
//            print("a")
//            //可以使总信号量减1，当信号总量为0时就会一直等待（阻塞所在线程），否则就可以正常执行
//            concurrent.async {
//
//                print("iii=\(i)")
//
//                print("wait")
//            }
//             print("d")
//        }
//        print("fish")
//
//        //信号量处理线程同步 将异步执行任务转化为同步执行任务。如必须等待异步的网络请求返回后才能执行后续任务时。
//        DispatchQueue.global().async {
//            sleep(arc4random()%5)//休眠时间随机
//            print("completed")
//            semaphore.signal()
//        }
//        switch semaphore.wait(timeout: DispatchTime.now()+10) {//信号量为0，调用wait后阻塞线程
//        case .success:
//            print("success")
//        case .timedOut:
//            print("timeout")
//        }
//        print("over")
//
//        //信号量控制最大并发数 在Operation中可以通过maxConcurrentOperationCount轻松实现控制最大并发数，GCD中需要借助信号量实现。以下代码就限制了最多两个任务并发执行。
//        let semaphore2Number = DispatchSemaphore(value: 2)
//        for i in 0...10 {
//            semaphore2Number.wait()//当信号量为0时，阻塞在此
//            DispatchQueue.global().async {
//                sleep(3)
//                print(i,Thread.current)
//                semaphore2Number.signal()//信号量加1
//            }
//            print("=======================")
//        }
//
//        //使用DispatchSemaphore加锁 非线程安全，即当一个变量可能同时被多个线程修改。以下代码如果不使用信号量输出是随机值。
//
//        var i = 0
//        for _ in 1...10 {
//            print("xunhuankaihi")
//            DispatchQueue.global().async {
//                print("kaishi")
//                semaphore.wait()//当信号量为0时，阻塞在此
//                for _ in 1...10 {
//                    i += 1
//                }
//                print(i)
//                print("zhongjian")
//                semaphore.signal()//信号量加1
//                print("jiesu")
//
//            }
//            print("xunhuanjiesu")
//
//        }
        
//        //异步变同步
//        semaphoreSync()
//        //线程不安全，未加锁
//        initTicketStatusNotSave()
//        //线程安全，已经枷锁
//        initTicketStatusSaveAnquan()
    }
//    func semaphoreSync(){
//        print("mainThread---\(Thread.current)")
//        print("begin")
//        let semaphore = DispatchSemaphore.init(value: 0)
//        var number = 0
//        DispatchQueue.global().async {
//            sleep(2)//耗时操作
//            print("1---\(Thread.current)")
//            number = 100
//            semaphore.signal()
//        }
//        semaphore.wait()//等待异步任务执行完成才可以继续执行
//        print("end,number = \(number)")
//    }
//    /**
//    * 非线程安全：不使用 semaphore
//    * 初始化火车票数量、卖票窗口（非线程安全）、并开始卖票
//    */
//    func initTicketStatusNotSave(){
//        print("mainThread---\(Thread.current)")
//        
//        let queue1 = DispatchQueue.init(label: "queue1")//窗口1
//        let queue2 = DispatchQueue.init(label: "queue2")//窗口2
//        queue1.async {
//            self.saleTickeNotSafe()//开始卖票
//        }
//        queue2.async {
//            self.saleTickeNotSafe()//开始卖票
//        }
//    }
//    /**
//    * 售卖火车票（非线程安全）
//    */
//    var snums:Int = 0
//    var num:Int = 0
//    func saleTickeNotSafe(){
//        while true {
//            if self.snums > 0{
//                self.snums = self.snums - 1
//                print("剩余票数：\(self.snums), 窗口：\(Thread.current)")
//                Thread.sleep(forTimeInterval: 0.2)
//            }else{
//                print("所有火车票已卖完")
//                break
//            }
//        }
//    }
//    var semaphoreSave:DispatchSemaphore
//    func initTicketStatusSaveAnquan(){
//        print("mainThread---\(Thread.current)")
//        
//        let queue1 = DispatchQueue.init(label: "queue1")//窗口1
//        let queue2 = DispatchQueue.init(label: "queue2")//窗口2
//        self.semaphoreSave = DispatchSemaphore.init(value: 1)//初始化信号量值为1
//        queue1.async {
//            self.saleTickeSafeAnquan()//开始卖票
//        }
//        queue2.async {
//            self.saleTickeSafeAnquan()//开始卖票
//        }
//    }
//    /**
//    * 售卖火车票
//    */
//    func saleTickeSafeAnquan(){
//        while true {
//            self.semaphoreSave.wait()//检测信号量：大于0减1继续执行，少于等于0则等待
//            if self.num > 0{
//                self.num = self.num - 1
//                print("剩余票数：\(self.num), 窗口：\(Thread.current)")
//                Thread.sleep(forTimeInterval: 0.2)
//            }else{
//                print("所有火车票已卖完")
//                self.semaphoreSave.signal()//信号量加1
//                break
//            }
//            self.semaphoreSave.signal()//信号量加1
//        }
//    }
    //延迟任务
    func dispacthAfter() ->Void{
        
        //使用GCD执行延时任务指定的并不是任务的执行时间，而是加入队列的时间。所以执行时间可能不太精确。但是任务是通过闭包加入，相较performSelectorAfterDelay可读性更好，也更安全
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2) {
            print("延时任务")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("延时主线程任务")
        }
    }
    
    //DispatchWorkItem
    func gcdDispatchWorkItem()->Void{
        //在swift3以后dispatch_once被废弃。swift中有更好的定义单例和一次性代码的方式。DispatchWorkItem与任务取消,DispatchWorkItem其实就是用来代替OC中的dispatch_block_t。如果任务是通过DispatchWorkItem定义。在执行之前，可以执行取消操作。注意即使任务已经加入队列，只要还未执行就可以进行取消，但是无法判断任务在队列中的状态，所以一般会根据加入队列的时间确定是否可以取消。

        //DispatchWorkItem主动执行
        let workItem = DispatchWorkItem {
            print("延时任务")
        }
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now()+2, execute: workItem)
        sleep(1)
        workItem.cancel()
        
        //等待DispatchWorkItem执行完成
        let workItemWait = DispatchWorkItem {
            sleep(3)
            print("workItem")
        }
        DispatchQueue.global().async(execute: workItemWait)
        switch workItemWait.wait(timeout: DispatchTime.now()+5) {
        case .success:
            print("success")
        case .timedOut:
            print("timeout")
        }
        
        //DispatchWorkItem执行完成通知
        let workItemNoti = DispatchWorkItem {
            sleep(3)
            print("workItem")
        }
        DispatchQueue.global().async(execute: workItemNoti)
        workItemNoti.notify(queue: DispatchQueue.main) {
            print("completed")
        }
       
    }
    var thread:Thread!;
    func longThread(){
        // 需要在某个地方初始化
        thread = Thread.init(target: self, selector:#selector(startRunlooThread(beacons: )), object: nil)
        thread.start()
        //需要长时间处理数据的地方使用此方式
        self.perform(#selector(otherNeedMoreTime), on: thread, with: nil, waitUntilDone: false)
        
        //关闭线程常住
//        RunLoop.current.remove(NSMachPort(), forMode: .common)
//        thread.cancel()
    }
    
    @objc func startRunlooThread(beacons:Array<AnyObject>){
        
        print("当前线程 =poart= \(Thread.current)  == beacons==\(beacons)")
//        autoreleasepool {
            
            print("当前线程 =poart= \(Thread.current)")
            
            let currentThread: Thread = Thread.current
            currentThread.name = "常驻线程"
            
            RunLoop.current.add(NSMachPort(), forMode: .common)
            RunLoop.current.run()
//        }
        
        
    }
    @objc func otherNeedMoreTime() ->Void{
        autoreleasepool {
        //chuli
        }
        currentTreadLog()
    }
    func currentTreadLog() ->Void{
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
