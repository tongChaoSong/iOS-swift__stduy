//
//  HXImage.swift
//  sharesChonse
//
//  Created by 冯汉栩 on 2018/1/24.
//  Copyright © 2018年 fenghanxuCompany. All rights reserved.
//

/*
 // 1. 在main bundle中找到特定bundle
 NSString *sampleBundlePath = [[NSBundle mainBundle] pathForResource:@"SampleBundle.bundle" ofType:nil];
 // 2. 载入bundle，即创建bundle对象
 NSBundle *sampleBundle = [NSBundle bundleWithPath:sampleBundlePath];
 // 3. 从bundle中获取资源路径
 // 注意这里的图片位于通用资源目录下的Images二级目录，相对路径要明确这种关系
 NSString *pic1Path = [sampleBundle pathForResource:@"pic1.png" ofType:nil];
 // 4. 通过路径创建对象
 UIImage *image = [UIImage imageWithContentsOfFile:pic1Path];
 
 */

import UIKit

class HXImage: UIImage {
    //图片要放在外面，别放在Assets.xcassets里面，不然访问不了
   class func imageNamePDF(name:String) -> UIImage{
        var fileName = name
        if !fileName.hasSuffix(".pdf") { fileName += ".pdf" }
        let path = Bundle.main.path(forResource: fileName, ofType: nil, inDirectory: nil)
        let url:URL = URL(fileURLWithPath: path!)
        let page:Int = 1
        let screenScale:CGFloat = UIScreen.main.scale
        let pdfRef:CGPDFDocument = CGPDFDocument(url as CFURL)!
        let imagePage:CGPDFPage = pdfRef.page(at: page)!
        let pdfRect:CGRect = imagePage.getBoxRect(CGPDFBox.cropBox)
        let contextSize = pdfRect.size
        let colorSpace:CGColorSpace = CGColorSpaceCreateDeviceRGB()
        let context:CGContext = CGContext(data: nil, width: Int(contextSize.width * screenScale), height: Int(contextSize.height * screenScale), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: UInt32(CGImageAlphaInfo.none.rawValue) | UInt32(CGImageAlphaInfo.premultipliedFirst.rawValue))!
        
        context.scaleBy(x: screenScale, y: screenScale)
        
        let drawingTransform:CGAffineTransform = imagePage.getDrawingTransform(CGPDFBox.cropBox, rect: pdfRect, rotate: 0, preserveAspectRatio: true)
        context.concatenate(drawingTransform)
        
        context.drawPDFPage(imagePage)
        context.setFillColorSpace(colorSpace)
        let image = context.makeImage()
    let pdfImage:UIImage = UIImage(cgImage: image!, scale: screenScale, orientation: UIImage.Orientation.up)
        return pdfImage
    }

}
