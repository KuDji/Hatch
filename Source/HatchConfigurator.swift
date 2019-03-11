//
// HatchConfigurator.swift
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

public final class HatchConfigurator {
    
    // MARK: - Parametrs
    
    var backgroundColor = UIColor.black.withAlphaComponent(0.7)
    
    var font = UIFont.systemFont(ofSize: 18)
    
    var closeMarkIsOn = true
    
    // MARK: - EdgeInsets Parametrs
    
    var inBoundsInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    init(backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.7),
         font: UIFont = UIFont.systemFont(ofSize: 18),
         closeMarkIsOn: Bool = true,
         inBoundsInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    {
        self.backgroundColor = backgroundColor
        self.font = font
        self.closeMarkIsOn = closeMarkIsOn
        self.inBoundsInsets = inBoundsInsets
    }
}