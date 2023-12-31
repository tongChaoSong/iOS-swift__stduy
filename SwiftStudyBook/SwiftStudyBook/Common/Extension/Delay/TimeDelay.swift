//
//  TimeDelay.swift
//  GuessFootball
//
//  Created by 冯汉栩 on 2018/3/21.
//  Copyright © 2018年 fenghanxuCompany. All rights reserved.
//

import Foundation

typealias Task = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
  
  func dispatch_later(block: @escaping ()->()) {
    let t = DispatchTime.now() + time
    DispatchQueue.main.asyncAfter(deadline: t, execute: block)
  }
  var closure: (()->Void)? = task
  var result: Task?
  
  let delayedClosure: Task = {
    cancel in
    if let internalClosure = closure {
      if (cancel == false) {
        DispatchQueue.main.async(execute: internalClosure)
      }
    }
    closure = nil
    result = nil
  }
  
  result = delayedClosure
  
  dispatch_later {
    if let delayedClosure = result {
      delayedClosure(false)
    }
  }
  return result
}

func cancel(_ task: Task?) {
  task?(true)
}
