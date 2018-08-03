//
//  UIImage+YYExtension.swift
//  vehicleLoanApp
//
//  Created by yuyou on 2018/3/9.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit

extension UIImage {

    //根据颜色返回一个纯色图片
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //把图片渲染成另一个颜色返回
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
