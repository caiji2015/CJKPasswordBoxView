//
//  CJKTextField+extension.swift
//  CJKit
//
//  Created by 蔡吉 on 2017/8/8.
//  Copyright © 2017年 caiji. All rights reserved.
//

import UIKit

class CJKTextField: UITextField {
    /// 不能复制粘贴
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

extension UITextField {
    /// 限制输入个数
    public func limit(_ length: Int) {
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
        guard let start = markedTextRange?.start else {
            limitText(length)
            return
        }
        guard let _ = position(from: start, offset: 0) else {
            limitText(length)
            return
        }
    }
    
    /// 限制文本输入个数
    private func limitText(_ length: Int) {
        if let theText = text {
            let textLength = theText.count
            /// ---字符处理
            if textLength > length {
                ///中文和emoj表情存在问题，需要对此进行处理
                var inputLength = 0
                var i = 0
                
                while i < textLength && inputLength <= length {
                    let index = theText.index(theText.startIndex, offsetBy: i)
                    let range = theText.rangeOfComposedCharacterSequence(at: index)
                    inputLength += String(theText[range]).count
                    if inputLength > length {
                        text = String(theText[..<range.lowerBound])
                    }
                    i += theText.distance(from: range.lowerBound, to: range.upperBound)
                }
            }
        }
    }
}
