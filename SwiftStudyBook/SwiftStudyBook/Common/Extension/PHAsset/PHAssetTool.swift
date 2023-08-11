//
//  PHAssetTool.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2018/6/19.
//  Copyright © 2018年 fenghanxuCompany. All rights reserved.
//

import UIKit
import Photos

class PHAssetTool: NSObject {
  //单张图片
  @objc class func PHAssetToImageSingle(asset:PHAsset) -> UIImage{
    var image = UIImage()
    
    // 新建一个默认类型的图像管理器imageManager
    let imageManager = PHImageManager.default()
    
    // 新建一个PHImageRequestOptions对象
    let imageRequestOption = PHImageRequestOptions()
    
    // PHImageRequestOptions是否有效
    imageRequestOption.isSynchronous = true
    
    // 缩略图的压缩模式设置为无
    imageRequestOption.resizeMode = .none
    
    // 缩略图的质量为高质量，不管加载时间花多少
    imageRequestOption.deliveryMode = .highQualityFormat
    
    // 按照PHImageRequestOptions指定的规则取出图片
    imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 1080, height: 1920), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
      (result, _) -> Void in
      image = result!
    })
    return image
    
  }
  
    //多张数组
  @objc class func PHAssetToImageList(assetList:[PHAsset]) -> [UIImage]{
    var imageList = [UIImage]()
    
    // 新建一个默认类型的图像管理器imageManager
    let imageManager = PHImageManager.default()
    
    // 新建一个PHImageRequestOptions对象
    let imageRequestOption = PHImageRequestOptions()
    
    // PHImageRequestOptions是否有效
    imageRequestOption.isSynchronous = true
    
    // 缩略图的压缩模式设置为无
    imageRequestOption.resizeMode = .none
    
    // 缩略图的质量为高质量，不管加载时间花多少
    imageRequestOption.deliveryMode = .highQualityFormat
    
    for item in assetList {
      // 按照PHImageRequestOptions指定的规则取出图片
      imageManager.requestImage(for: item, targetSize: CGSize.init(width: 1080, height: 1920), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
        (result, _) -> Void in
        guard let image = result else { return }
//        image = result!
        imageList.append(image)        
      })
    }
    return imageList
    
  }

}
