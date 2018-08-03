//
//  YYUtilsMacro.swift
//  salesManVehicleLoanApp
//
//  Created by yuyou on 2018/4/12.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit

//苹果4宽高
let IPHONE_4_SCREEN_WIDTH = CGFloat(320.0)
let IPHONE_4_SCREEN_HEIGHT = CGFloat(480.0)
//苹果5宽高
let IPHONE_5_SCREEN_WIDTH = CGFloat(320.0)
let IPHONE_5_SCREEN_HEIGHT = CGFloat(568.0)
//苹果6宽高
let IPHONE_6_SCREEN_WIDTH = CGFloat(375.0)
let IPHONE_6_SCREEN_HEIGHT = CGFloat(667.0)
//苹果6plus宽高
let IPHONE_6PLUS_SCREEN_WIDTH = CGFloat(414.0)
let IPHONE_6PLUS_SCREEN_HEIGHT = CGFloat(736.0)
//苹果X宽高
let IPHONE_X_SCREEN_WIDTH = CGFloat(375.0)
let IPHONE_X_SCREEN_HEIGHT = CGFloat(812.0)
//底部安全高度
let BOTTOM_SAFE_HEIGHT = (isIPhoneX ? CGFloat(34.0) : CGFloat(0))
//系统手势高度
let SYSTEM_GESTURE_HEIGHT = (isIPhoneX ? CGFloat(13.0) : CGFloat(0))
//tabbar高度
let TABBAR_HEIGHT = (CGFloat(49.0) + BOTTOM_SAFE_HEIGHT)
//状态栏高度
let STATUS_HEIGHT = (isIPhoneX ? CGFloat(44.0) : CGFloat(20.0))
//导航栏高
let NAVBAR_HEIGHT = CGFloat(44.0)

//是不是iphoneX
let isIPhoneX = (kMainScreenWidth == CGFloat(IPHONE_X_SCREEN_WIDTH) && kMainScreenHeight == CGFloat(IPHONE_X_SCREEN_HEIGHT))


/** 屏幕判断 */
let IS_X_SCREEN = (kMainScreenHeight == CGFloat.init(IPHONE_X_SCREEN_HEIGHT) && kMainScreenWidth == CGFloat.init(IPHONE_X_SCREEN_WIDTH))
let IS_PLUS_SCREEN = (kMainScreenHeight == CGFloat.init(IPHONE_6PLUS_SCREEN_HEIGHT) && kMainScreenWidth == CGFloat.init(IPHONE_6PLUS_SCREEN_WIDTH))
let IS_6_7_8_SCREEN = (kMainScreenHeight == CGFloat.init(IPHONE_6_SCREEN_HEIGHT) && kMainScreenWidth == CGFloat.init(IPHONE_6_SCREEN_WIDTH))
let IS_5_SE_SCREEN = (kMainScreenHeight == CGFloat.init(IPHONE_5_SCREEN_HEIGHT) && kMainScreenWidth == CGFloat.init(IPHONE_5_SCREEN_WIDTH))


/** 设备屏幕宽 */
let kMainScreenWidth = UIScreen.main.bounds.size.width
/** 设备屏幕高 */
let kMainScreenHeight = UIScreen.main.bounds.size.height



/** 创建用于展示的string */
func CREATE_SHOW_STRING_WITH_PLACEHOLDER(originalString: String?, placeHolderString: String) -> String! {
    if (originalString == nil || originalString == "") {
        return placeHolderString
    } else {
        return originalString
    }
}

/** 6位十六进制颜色转换 */
func UIColorFromRGB(hexValue: NSString) -> UIColor! {
    return UIAlphaColorFromRGB(hexValue: hexValue, alpha: 1.0)
}

/** 6位十六进制颜色转换，带透明度 */
func UIAlphaColorFromRGB(hexValue: NSString, alpha: CGFloat) -> UIColor! {
    var cString: String = hexValue.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased();
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1);
    }
    if (cString.count != 6) {
        return UIColor.clear;
    }
    
    let rString = (cString as NSString).substring(to: 2);
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2);
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2);
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r);
    Scanner(string: gString).scanHexInt32(&g);
    Scanner(string: bString).scanHexInt32(&b);
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha);
}
