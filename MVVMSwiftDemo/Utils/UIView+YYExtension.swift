//
//  UIView+YYExtension.swift
//  testVehicleLoanApp
//
//  Created by yuyou on 2018/3/9.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit

extension UIView {
    
    var yy_height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newYy_height) {
            self.frame.size.height = newYy_height
        }
    }
    
    var yy_width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newYy_width) {
            self.frame.size.width = newYy_width
        }
    }
    
    var yy_x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newYy_x) {
            self.frame.origin.x = newYy_x
        }
    }
    
    var yy_y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newYy_y) {
            self.frame.origin.y = newYy_y
        }
    }
    
    var yy_right: CGFloat {
        get {
            return self.frame.maxX;
        }
        set(newYy_right) {
            self.frame.origin.x = newYy_right - self.frame.size.width;
        }
    }
    
    var yy_bottom: CGFloat {
        get {
            return self.frame.maxY;
        }
        set(newYy_bottom) {
            self.frame.origin.y = newYy_bottom - self.frame.size.height;
        }
    }
    
    var yy_size: CGSize {
        get {
            return self.frame.size;
        }
        set(newYy_size) {
            self.frame.size = newYy_size;
        }
    }
    
    var yy_centerX: CGFloat {
        get {
            return self.center.x;
        }
        set(newYy_centerX) {
            self.center.x = newYy_centerX;
        }
    }
    
    var yy_centerY: CGFloat {
        get {
            return self.center.y;
        }
        set(newYy_centerY) {
            self.center.y = newYy_centerY;
        }
    }
    
    /** 获取根控制器 */
    func getRootVc() -> UIViewController? {
        if (self.next!.isKind(of: UIViewController.self)) {
            return self.next as! UIViewController!;
        }
        var superView: UIView? = self.superview;
        while (superView != nil) {
            let nextResponder: UIResponder = superView!.next!;
            if (nextResponder.isKind(of: UIViewController.self)) {
                return nextResponder as? UIViewController;
            }
            superView = superView!.superview;
        }
        return nil;
    }
}
