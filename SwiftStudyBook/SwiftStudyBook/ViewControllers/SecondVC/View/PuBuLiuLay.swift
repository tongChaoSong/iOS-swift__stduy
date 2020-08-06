//
//  PuBuLiuLay.swift
//  折上折
//
//  Created by apple on 2019/8/29.
//  Copyright © 2019 tcs.Orz.com. All rights reserved.
//

import UIKit

@objc protocol PuBuLiuCustFlowLayoutDelegate :NSObjectProtocol {

    //设置高度
    func hw_SetCellHeight(layout :PuBuLiuLay,index:NSIndexPath,itemWidth:CGFloat) -> CGFloat
    //设置行数
    @objc optional func hw_columCountInWaterFlaywLayout(layout :PuBuLiuLay) -> Int
    // 返回列间距
    @objc optional func hw_columMarginInWaterFlaywLayout(layout :PuBuLiuLay) -> CGFloat
    // 返回行间距
    @objc optional func hw_rowMarginInWaterFlowLayout(layout : PuBuLiuLay) -> CGFloat

    @objc optional func hw_edgeInsetsInWaterFlowLayout(layout : PuBuLiuLay) -> UIEdgeInsets


}
class PuBuLiuLay: UICollectionViewFlowLayout {

        weak open var delegate : PuBuLiuCustFlowLayoutDelegate?
    
        fileprivate let defaultColumnCount:Int = 2 //列数
        fileprivate let defaultColumnMargin:CGFloat = 10 // 列间距
        fileprivate let defaultRowMargin:CGFloat = 10 // 行间距
        fileprivate let defaultEdgeInsets:UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        fileprivate lazy var attrs:[UICollectionViewLayoutAttributes] = []
        /// 列高度数组
        fileprivate lazy var columnHeights:[CGFloat] = []
        /// 内容高度
        fileprivate lazy var contentHeight:CGFloat = 0.0
        /// MARK : - 列数
        fileprivate func columCoum() -> Int {
            if self.delegate != nil && ((self.delegate?.responds(to:#selector(self.delegate?.hw_columCountInWaterFlaywLayout(layout:))))!) {
                return ((self.delegate?.hw_columCountInWaterFlaywLayout!(layout: self))!);
            }
            else
            {
                return defaultColumnCount;
            }
    
        }
        // MARK: - 列间距
        fileprivate func columnMargin() -> CGFloat {
            if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.hw_columMarginInWaterFlaywLayout(layout:))))!{
                return (self.delegate?.hw_columMarginInWaterFlaywLayout!(layout: self))!
            }else{
                return defaultColumnMargin
            }
        }
        // MARK: - 行间距
        fileprivate func rowMargin() -> CGFloat {
            if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.hw_rowMarginInWaterFlowLayout(layout:))))!{
                return (self.delegate?.hw_rowMarginInWaterFlowLayout!(layout: self))!
            }else{
                return defaultRowMargin
            }
        }
        // MARK: - 额外区域
        fileprivate func edgeInsets() -> UIEdgeInsets {
            if self.delegate != nil && (self.delegate?.responds(to: #selector(self.delegate?.hw_edgeInsetsInWaterFlowLayout(layout:))))!{
                return (self.delegate?.hw_edgeInsetsInWaterFlowLayout!(layout: self))!
            }else{
                return defaultEdgeInsets
            }
        }
    
    
        override func prepare() {
            super.prepare()
            if self.collectionView == nil {
                return
            }
            /// 清除列高度数组
            self.columnHeights.removeAll()
            /// 清除内容高度
            self.contentHeight = 0
            /// 把每组的额外滚动区域高度添加进去
            for _ in 0 ..< self.columCoum() {
                self.columnHeights.append(self.edgeInsets().top)
            }
            /// 清除属性
            self.attrs.removeAll()
            /// 获取组数
            let count : Int = (self.collectionView?.numberOfItems(inSection: 0))!
            /// 获取宽度
            let width : CGFloat = (self.collectionView?.frame.size.width)!
            /// 获取列间距总和
            let colMagin = (CGFloat)(self.columCoum() - 1) * self.columnMargin()
            /// 计算cell宽度
            let cellWidth : CGFloat = (width - self.edgeInsets().left - self.edgeInsets().right - colMagin) / CGFloat(self.columCoum())
            
            for i in 0 ..< count {
                let indexPath : NSIndexPath = NSIndexPath(item: i, section: 0)
                let attr : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                
                //获取高度
                let cellHeight : CGFloat =  (self.delegate?.hw_SetCellHeight(layout: self, index: indexPath as NSIndexPath, itemWidth: cellWidth))!
                /// 默认最小高度为第一组
                var minColumnHeight = self.columnHeights[0]
                var minColumn : Int = 0
                /// 筛选最小高度的组
                for i in 1 ..< self.columCoum() {
                    let colHeight = self.columnHeights[i]
                    if colHeight < minColumnHeight {
                        minColumnHeight = colHeight
                        minColumn = i
                    }
                }
                /// 将下一个cell添加在最小高度的那一组
                let cellX : CGFloat = self.edgeInsets().left + CGFloat(minColumn) * (self.columnMargin() + cellWidth)
                var cellY = minColumnHeight
                if cellY != self.edgeInsets().top { // 如果不是第一次加入需要加上行间距
                    cellY = self.rowMargin() + cellY
                }
                /// 设置frame
                attr.frame = CGRect(x: cellX, y: cellY, width: cellWidth, height: cellHeight)
                /// 那么当前的最大Y值就是新加的这个Cell的底部
                let maxY = cellY + cellHeight;
                
                /// 修改该组的列高度
                self.columnHeights[minColumn] = maxY
                /// 比较当前的最大高度是否是大于内容高度的
                let maxContentHeight = self.columnHeights[minColumn]
                if CGFloat(self.contentHeight) < CGFloat(maxContentHeight) {
                    /// 大于修改内容高度
                    self.contentHeight = maxContentHeight
                }
                /// 添加属性数组
                self.attrs.append(attr)
            }
    }
    /// 返回属性数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrs
    }
    /// 返回内容高度
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: 0, height: CGFloat(self.contentHeight) + CGFloat(self.edgeInsets().bottom))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    
        }
}
