//
//  TipTextField.swift
//  MVVMSwiftDemo
//
//  Created by yuyou on 2018/8/2.
//  Copyright © 2018年 yy. All rights reserved.
//

import UIKit

class TipTextField: UIView {

    lazy var tipLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .left
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField.init()
        textField.font = UIFont.systemFont(ofSize: 14.0)
        textField.setValue(UIColorFromRGB(hexValue: "666666"), forKeyPath: "_placeholderLabel.textColor")
        textField.setValue(UIFont.systemFont(ofSize: 14.0), forKeyPath: "_placeholderLabel.font")
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColorFromRGB(hexValue: "ebebeb").cgColor
        textField.layer.cornerRadius = 8.0
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15.0, height: 50.0))
        return textField
    }()

    // MARK: 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init(frame: CGRect, placeHolder: String) {
        self.init(frame: frame)

        addSubview(tipLabel)
        addSubview(textField)
        tipLabel.frame = CGRect.init(x: 15.0, y: 0.0, width: yy_width - 15.0 * 2, height: yy_height * 0.3)
        textField.frame = CGRect.init(x: 15.0, y: yy_height * 0.3, width: yy_width - 15.0 * 2, height: yy_height * 0.7)

        textField.placeholder = placeHolder
    }
}
