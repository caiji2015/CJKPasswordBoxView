//
//  CJKPasswordBoxView.swift
//  CJKit
//
//  Created by 蔡吉 on 2017/8/9.
//  Copyright © 2017年 caiji. All rights reserved.
//

import UIKit

class CJKPasswordBoxView: UIView{
    /// 验证码位数
    var digit: Int = 4
    
    /// 是否密文
    var isSecure: Bool = true
    
    /// 格子间距
    var spacing: CGFloat = 0
    
    /// 密码内容
    var password: String = ""
    
    /// 边框颜色
    var borderColor: UIColor = UIColor.black
    
    /// 边框宽度
    var borderWidth: CGFloat = 1
    
    /// 边框圆角
    var cornerRadius: CGFloat = 1
    
    /// 存放CJKPasswordTextField数组
    var textFieldArray: [CJKPasswordTextField] = []
    
    /// 回调
    var complete: ((_ password: String) -> Void)?
    
    
    /// init方法
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - digit: 验证码位数
    ///   - isSecure: 是否密文
    ///   - spacing: 格子间距
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    ///   - cornerRadius: 边框圆角
    init(frame :CGRect,digit: Int,isSecure: Bool,spacing: CGFloat,borderColor: UIColor,borderWidth: CGFloat,cornerRadius: CGFloat,complete:((_ password: String)->Void)? = nil) {
        super.init(frame: frame)
        self.digit = digit
        self.isSecure = isSecure
        self.spacing = spacing
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.complete = complete
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化界面
    func setupUI(){
        for i in 0..<digit {
            let passwordTextField = CJKPasswordTextField(frame: CGRect(x: CGFloat(i)*width/CGFloat(digit)+spacing/2, y: 0, width: width/CGFloat(digit)-spacing, height: height))
            passwordTextField.backgroundColor = .clear
            passwordTextField.cjkDelegate = self
            passwordTextField.delegate = self
            passwordTextField.keyboardType = .numberPad
            passwordTextField.layer.borderColor = borderColor.cgColor
            passwordTextField.layer.borderWidth = borderWidth
            passwordTextField.layer.cornerRadius = cornerRadius
            passwordTextField.tag = 100+i
            passwordTextField.textAlignment = .center
            passwordTextField.isSecureTextEntry = isSecure
            addSubview(passwordTextField)
            textFieldArray.append(passwordTextField)
        }
    }
    
    /// 点击收回键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for textfield in textFieldArray {
            textfield.resignFirstResponder()
        }
    }
}

extension CJKPasswordBoxView: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = string
        getPassword()
        if (textField.text?.count)! > 0 {
            if textField.tag < (digit + 99) {
                textFieldArray[textField.tag-99].becomeFirstResponder()
            }
        }
        return false;
    }
    
    /// 在里面改变选中状态以及获取验证码
    func textFieldDidBeginEditing(_ textField: UITextField) {
        getPassword()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        getPassword()
    }
    
    func getPassword(){
        var string = String()
        for textField in textFieldArray {
            string += textField.text!
        }
        /// 判断长度是否达到
        if string.count == digit{
            if let complete = complete {
                complete(string)
            }
        }
        password = string
    }
}


extension CJKPasswordBoxView: CJKPasswordTextFieldDelegate{
    func textFeildDeleteBackward(_ textField: UITextField) {
        if textField.tag > 100 {
            let newTextField = textFieldArray[textField.tag-101]
            newTextField.text = ""
            newTextField.becomeFirstResponder()
        }
    }
}

/// CJKPasswordTextFieldDelegate
protocol CJKPasswordTextFieldDelegate{
    func textFeildDeleteBackward(_ textField: UITextField)
}


/// CJKPasswordTextField
class CJKPasswordTextField: CJKTextField{
    var cjkDelegate: CJKPasswordTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        if cjkDelegate != nil {
            cjkDelegate?.textFeildDeleteBackward(self)
        }
    }
}
