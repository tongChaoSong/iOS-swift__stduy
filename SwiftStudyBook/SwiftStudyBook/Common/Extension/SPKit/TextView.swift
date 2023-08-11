//
//  TextView.swift
//  B7iOSBuy
//
//  Created by BigL on 2016/11/29.
//  Copyright © 2016年 www.spzjs.com. All rights reserved.
//

import UIKit

@objc protocol TextViewDelegate: AnyObject {
  @objc optional func textView(shouldBeginEditing textView: UITextView)
  @objc optional func textView(didEndEditing textView: UITextView)
  @objc optional func textView(didChange textView: UITextView)
}

class TextView: UIView {
  
  fileprivate let textView = UITextView()
  fileprivate let placeHolderLabel = UILabel()
  fileprivate let wordCountLabel = UILabel()
  
  weak var delegate: TextViewDelegate?
  //直接赋值内容
  var text: String{
    set{
      textView.text = newValue
      guard wordLimit != -1 else { return }
      textView.text = newValue.substringInclude(behind: wordLimit)
      placeHolderLabel.isHidden = !textView.text.isEmpty
      wordCountLabel.text = "\(text.length)/\(wordLimit)字"
    }
    get{ return textView.text }
  }
  //设置字数显示
  var wordLimit: Int = -1 {
    didSet{ wordCountLabel.text = "0/\(wordLimit)字" }
  }
  //设置占位字符
  var placeHolder: String?{
    set{ placeHolderLabel.text = newValue }
    get{ return placeHolderLabel.text }
  }
  //设置内容字体大小
  var font: UIFont? {
    set{ textView.font = newValue }
    get{ return textView.font }
  }
    
    /// 占位文字颜色
    public var placeHolderColor: UIColor{
        set{ placeHolderLabel.textColor = newValue }
        get{ return placeHolderLabel.textColor }
    }
    
    /// 字数限制文字颜色
    public var wordLimitColor: UIColor{
        set{ wordCountLabel.textColor = newValue }
        get{ return wordCountLabel.textColor }
    }
    
    /// 是否显示字数限制
    public var isShowWordLimit = false{
        didSet{
            
            wordCountLabel.isHidden = !isShowWordLimit
        }
    }
		
  override init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension TextView{
  fileprivate func buildUI() {
    backgroundColor = Color.background
    addSubview(textView)
    textView.addSubview(placeHolderLabel)
    addSubview(wordCountLabel)
    buildLayout()
    buildSubView()
  }
  
  fileprivate func buildLayout() {
    textView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
    placeHolderLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(Space5)
      make.left.equalToSuperview().offset(Space10)
    }
    wordCountLabel.snp.makeConstraints { (make) in
      make.bottom.equalTo(textView.snp.bottom)
      make.right.equalTo(textView.snp.right).offset(-Space5)
    }
  }
  
  fileprivate func buildSubView() {
    placeHolderLabel.textColor = Color.line
    wordCountLabel.textAlignment = .right
    wordCountLabel.textColor = Color.line
    textView.font = Font.font13
    textView.delegate = self
  }
  
}

extension TextView: UITextViewDelegate{
  
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    placeHolderLabel.isHidden = true
    delegate?.textView?(shouldBeginEditing: textView)
    return true
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    placeHolderLabel.isHidden = !textView.text.isEmpty
    delegate?.textView?(didEndEditing: textView)
  }
  
  func textViewDidChange(_ textView: UITextView) {
    guard textView.markedTextRange == nil else { return }
    guard let text = textView.text else { return }
    let range = textView.selectedTextRange
    
//    if text.hasEmoji { textView.text = textView.text?.removedEmoji }
//    if text.isLawful { textView.text = textView.text?.removeLawful }
    
    if text.has(.emojis) { textView.text = textView.text?.removed(.emojis)}
    if text.is(.unLawful) {textView.text = textView.text?.removed(.unLawful)}
    
    delegate?.textView?(didChange: textView)
    
    guard wordLimit > 0 else { return }
    if textView.text.length > wordLimit {
      textView.text = textView.text.substringInclude(behind: wordLimit)
    }
    wordCountLabel.text = textView.text.length.string.append("/\(wordLimit)字")
    textView.selectedTextRange = range
  }
  
  func textView(_ textView: UITextView,
                shouldChangeTextIn range: NSRange,
                replacementText text: String) -> Bool {
    
//    if text.hasEmoji { return false }
//    if !text.isLawful { return false }
    
    if text.has(.emojis) { return false }
    if text.is(.unLawful) { return false }
    
    return true
  }
    
}
