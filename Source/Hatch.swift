//
// Hatch.swift
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
import SnapKit

open class Hatch {
    
    // MARK: - Variable
    
    private var bench: HatchBench
    
    private var config: HatchConfigurator
    
    // MARK: - View's
    
    private weak var parentView: UIView!
    
    private var backgroundView: UIView?
    
    private var batchView: UIView?
    
    private var closeMarkImage: UIImageView?
    
    private var previousElement: UIView?
    
    // MARK: - Init
    
    public init(bench: HatchBench, closeMark: HatchCloseMark? = nil, configuraction: HatchConfigurator, onView: UIView) {
        self.bench = bench
        self.config = configuraction
        self.parentView = onView
        
        setupBackgroundBlurView(configuraction: configuraction, view: onView)
        setup(bench)
        
        if let closeMark = closeMark {
            setup(closeMark)
        }
    }
    
    // MARK: - Presentation
    
    open func present(removeView: Selector? = nil, selectorClass: Any? = nil) {
        guard let parent = parentView else { return }
        if let backgroundView = backgroundView {
            parent.addSubview(backgroundView)
            if selectorClass == nil && removeView == nil {
                backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
            } else {
                backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: selectorClass, action: removeView))
            }
            addConstraintBackgroundBlurView()
        }
        if let batchView = batchView {
            parent.addSubview(batchView)
            addConstraintBatchView()
        }
        if let closeMarkImage = closeMarkImage {
            if selectorClass == nil && removeView == nil {
                closeMarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove)))
            } else {
                closeMarkImage.addGestureRecognizer(UITapGestureRecognizer(target: selectorClass, action: removeView))
            }
        }
    }
    
    @objc func remove() {
        batchView?.removeFromSuperview()
        backgroundView?.removeFromSuperview()
    }
    
    open func removeHatch() {
        remove()
    }
    
    // MARK: - Adding new Elements
    
    open func addLabel(_ hatcnLabel: HatchLabel) {
        let label = UILabel()
        label.text = hatcnLabel.text
        label.font = hatcnLabel.font
        label.textColor = hatcnLabel.color
        label.numberOfLines = hatcnLabel.lines
        label.textAlignment = .center
        
        guard let batchView = batchView else { return }
        let labelWidth = batchView.frame.size.width - hatcnLabel.edgeInset.left - hatcnLabel.edgeInset.right
        let textHeight = hatcnLabel.text.height(withConstrainedWidth: labelWidth, font: hatcnLabel.font)
        batchView.addSubview(label)
        
        label.snp.makeConstraints { make in
            
            if let previousElement = previousElement {
                make.top.equalTo(previousElement.snp.bottom).offset(hatcnLabel.edgeInset.top)
            } else {
                make.top.equalToSuperview().offset(hatcnLabel.edgeInset.top)
            }
            make.left.equalToSuperview().offset(hatcnLabel.edgeInset.left)
            make.right.equalToSuperview().offset(-hatcnLabel.edgeInset.right)
            make.height.equalTo(textHeight)
        }
        
        previousElement = label
        increaseBatchHeight(textHeight + hatcnLabel.edgeInset.bottom)
    }
    
    open func addImage(_ hatchImage: HatchUIImageView) {
        let image = UIImageView(image: hatchImage.image)
        batchView?.addSubview(image)
        
        image.snp.makeConstraints { make in
            
            if let previousElement = previousElement {
                make.top.equalTo(previousElement.snp.bottom).offset(hatchImage.edgeInset.top)
            } else {
                make.top.equalToSuperview().offset(hatchImage.edgeInset.top)
            }
            make.centerX.equalTo(batchView!)
            
            make.height.equalTo(hatchImage.size.height)
            make.width.equalTo(hatchImage.size.width)
        }
        
        previousElement = image
        increaseBatchHeight(hatchImage.size.height + hatchImage.edgeInset.bottom)
    }
    
    open func addButton(_ hatchButton: HatchButton) {
        let button = UIButton()
        button.addTarget(nil, action: hatchButton.action, for: .touchUpInside)
        button.setTitle(hatchButton.text, for: UIControl.State())
        button.titleLabel?.font = hatchButton.font
        button.setTitleColor(hatchButton.textColor, for: UIControl.State())
        button.backgroundColor = hatchButton.backgroundColor
        button.layer.cornerRadius = hatchButton.cornerRadius
        
        batchView?.addSubview(button)
        
        button.snp.makeConstraints { make in
            if let previousElement = previousElement {
                make.top.equalTo(previousElement.snp.bottom).offset(hatchButton.edgeInset.top)
            } else {
                make.top.equalToSuperview().offset(hatchButton.edgeInset.top)
            }
            make.left.equalToSuperview().offset(hatchButton.edgeInset.left)
            make.right.equalToSuperview().offset(-hatchButton.edgeInset.right)
            make.height.equalTo(hatchButton.height)
        }
        
        previousElement = button
        increaseBatchHeight(hatchButton.height + hatchButton.edgeInset.bottom)
    }
    
    open func addImageButton(_ hatchButton: HatchImageButton) {
        let button = createButton(from: hatchButton)
        batchView?.addSubview(button)
        
        button.snp.makeConstraints { make in
            if let previousElement = previousElement {
                make.top.equalTo(previousElement.snp.bottom).offset(hatchButton.edgeInset.top)
            } else {
                make.top.equalToSuperview().offset(hatchButton.edgeInset.top)
            }
            make.centerX.equalTo(batchView!)
            make.height.equalTo(hatchButton.size.height)
            make.width.equalTo(hatchButton.size.width)
        }
        
        previousElement = button
        increaseBatchHeight(hatchButton.size.height + hatchButton.edgeInset.bottom)
    }
    
    open func addImageButton(contentOf hatchButtons: [HatchImageButton]) {
        
        let stackWidth = hatchButtons
            .map { imageButton -> CGFloat in
                return imageButton.size.width + imageButton.edgeInset.left + imageButton.edgeInset.right
            }.reduce(0.0, +)
        
        var startPoint: CGFloat = -(stackWidth/2)
        var stackPosition: [CGFloat] = []
        
        hatchButtons.forEach { imageButton in
            let imageCenter = imageButton.size.width/2
            let buttonPosition = startPoint + imageButton.edgeInset.left + imageCenter
            stackPosition.append(buttonPosition)
            startPoint += imageButton.size.width + imageButton.edgeInset.left + imageButton.edgeInset.right
        }
        
        for i in 0..<hatchButtons.count {
            let button = createButton(from: hatchButtons[i])
            batchView?.addSubview(button)
            
            button.snp.makeConstraints { make in
                if let previousElement = previousElement {
                    make.top.equalTo(previousElement.snp.bottom).offset(hatchButtons[i].edgeInset.top)
                } else {
                    make.top.equalToSuperview().offset(hatchButtons[i].edgeInset.top)
                }
                make.centerX.equalToSuperview().offset(stackPosition[i])
                make.height.equalTo(hatchButtons[i].size.height)
                make.width.equalTo(hatchButtons[i].size.width)
            }
            
            if i == hatchButtons.count-1 {
                previousElement = button
                increaseBatchHeight(hatchButtons[i].size.height + hatchButtons[i].edgeInset.bottom)
            }
        }
    }
    
    private func createButton(from hatchButton: HatchImageButton) -> UIButton {
        let button = UIButton()
        button.addTarget(nil, action: hatchButton.action, for: .touchUpInside)
        button.setTitle("", for: UIControl.State())
        button.setImage(hatchButton.image, for: UIControl.State.normal)
        button.imageEdgeInsets = hatchButton.inBoundsEdgeInsets
        return button
    }
    
    // MARK: - Setup backgrounds
    
    private func setupBackgroundBlurView(configuraction: HatchConfigurator, view: UIView) {
        backgroundView = UIView()
        backgroundView?.backgroundColor = configuraction.backgroundColor
    }
    
    private func setup(_ bench: HatchBench) {
        batchView = UIView()
        batchView?.backgroundColor = bench.color
        batchView?.frame = CGRect(origin: CGPoint.zero,
                                  size: CGSize(width: bench.sizeWidth,
                                               height: bench.edgeInset.top))
        batchView?.layer.cornerRadius = bench.cornerRadius
    }
    
    private func setup(_ closeMark: HatchCloseMark) {
        guard let batchView = batchView else { return }
        let closeMarkImage = UIImageView(image: closeMark.image)
        batchView.addSubview(closeMarkImage)
        
        closeMarkImage.snp.makeConstraints { make in
            
            switch closeMark.position {
            case .topLeft:
                make.left.equalTo(batchView.snp.left).offset(closeMark.edgeInset.left)
                make.bottom.equalTo(batchView.snp.top).offset(-closeMark.edgeInset.bottom)
            case .topRight:
                make.right.equalTo(batchView.snp.right).offset(closeMark.edgeInset.right)
                make.bottom.equalTo(batchView.snp.top).offset(-closeMark.edgeInset.bottom)
            case .bottomLeft:
                make.left.equalTo(batchView.snp.left).offset(closeMark.edgeInset.left)
                make.top.equalTo(batchView.snp.bottom).offset(-closeMark.edgeInset.top)
            case .bottomRight:
                make.right.equalTo(batchView.snp.right).offset(closeMark.edgeInset.right)
                make.top.equalTo(batchView.snp.bottom).offset(-closeMark.edgeInset.top)
            }
            
            make.height.equalTo(closeMark.size.height)
            make.width.equalTo(closeMark.size.width)
        }
    }
    
    // MARK: - Constraint backgrounds
    
    private func addConstraintBackgroundBlurView() {
        backgroundView?.snp.makeConstraints { make in
            make.edges.equalTo(parentView)
        }
    }
    
    private func addConstraintBatchView() {
        guard let batchView = batchView else { return }
        
        batchView.snp.makeConstraints { make in
            make.center.equalTo(parentView)
            make.width.equalTo(bench.sizeWidth)
            make.height.equalTo(bench.edgeInset.top + bench.edgeInset.bottom)
        }
    }
    
    private func increaseBatchHeight(_ addHeight: CGFloat) {
        bench.edgeInset.top += addHeight
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = self.backgroundColor?.withAlphaComponent(0.8)
            } else {
                backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
    }
}
