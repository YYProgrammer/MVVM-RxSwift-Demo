//
//  FirstViewController.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/1.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit
import RxSwift

class FirstViewController: UIViewController {

    // MARK: 界面组件
    private lazy var nameTextField: TipTextField = {
        let textfield = TipTextField.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 70.0), placeHolder: "输入姓名")
        return textfield
    }()
    private lazy var pwdTextField: TipTextField = {
        let textfield = TipTextField.init(frame: CGRect.init(x: 0, y: 0, width: kMainScreenWidth, height: 70.0), placeHolder: "输入密码")
        return textfield
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 15.0, y: 0, width: kMainScreenWidth - 2 * 15.0, height: 44.0))
        button.setTitle("登录", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColorFromRGB(hexValue: "FF6600")), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIColorFromRGB(hexValue: "FF5C00")), for: .highlighted)
        button.setBackgroundImage(UIImage.imageWithColor(color: UIAlphaColorFromRGB(hexValue: "FF6600", alpha: 0.5)), for: .disabled)
        return button
    }()

    // MARK: viewModel
    var viewModel: FirstViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // 添加子控件
        view.addSubview(nameTextField)
        view.addSubview(pwdTextField)
        view.addSubview(loginButton)
        // 布局子控件
        nameTextField.yy_y = STATUS_HEIGHT + 20.0
        pwdTextField.yy_y = nameTextField.yy_bottom + 10.0
        loginButton.yy_y = pwdTextField.yy_bottom + 40.0
        //绑定viewModel
        viewModel = FirstViewModel.init(nameTextField: nameTextField, pwdTextField: pwdTextField, loginButton: loginButton)
    }
}
