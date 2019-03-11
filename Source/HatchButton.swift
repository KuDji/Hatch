//
// HatchButton.swift
//
// Copyright (c) 2019 Anatoliy Morozov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public final class HatchButton: HatchElementProtocol {
    
    var text: String
    
    var font: UIFont
    
    var textColor: UIColor
    
    var backgroundColor: UIColor
    
    var cornerRadius: CGFloat
    
    var height: CGFloat
    
    var edgeInset: UIEdgeInsets
    
    var action: Selector
    
    init(text: String,
         font: UIFont = UIFont.systemFont(ofSize: 18),
         textColor: UIColor = UIColor.white,
         backgroundColor: UIColor = UIButton().tintColor,
         cornerRadius: CGFloat = 8,
         height: CGFloat = 50,
         edgeInset: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
         action: Selector)
    {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.height = height
        self.edgeInset = edgeInset
        self.action = action
    }
}
