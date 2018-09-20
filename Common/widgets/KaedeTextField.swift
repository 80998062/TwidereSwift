//
//  File.swift
//  twidere
//
//  Created by 沈烨坷 on 2018/9/7.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import UIKit

/**
 A KaedeTextField is a subclass of the TextFieldEffects object, is a control that displays an UITextField with a customizable visual effect around the foreground of the control.
 */
@IBDesignable open class KaedeTextField: TextFieldEffects {
    /**
     The color of the placeholder text.
     
     This property applies a color to the complete placeholder string. The default value for this property is a black color.
     */
    @IBInspectable dynamic open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The scale of the placeholder font.
     
     This property determines the size of the placeholder label relative to the font size of the text field.
     */
    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.8 {
        didSet {
            updatePlaceholder()
        }
    }
    
    /**
     The view’s foreground color.
     
     The default value for this property is a clear color.
     */
    @IBInspectable dynamic open var foregroundColor: UIColor? {
        didSet {
            updateForegroundColor()
        }
    }
    
    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            drawViewsForRect(bounds)
        }
    }
    
    private let foregroundView = UIView(frame: CGRect.zero)
    private let placeholderInsets = CGPoint(x: 24, y: 5)
    private let textFieldInsets = CGPoint(x: 24, y: 0)
    
    private let inputEntryWidthRatio: CGFloat = 0.7
    private let foregroundWidthRatio: CGFloat = 0.75  // placeholdWithRatio = 1 - thisValue
    
    // MARK: - TextFieldEffects
    override open func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: .zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        foregroundView.frame = frame
        foregroundView.isUserInteractionEnabled = false
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        updateForegroundColor()
        updatePlaceholder()
        
        if text!.isNotEmpty || isFirstResponder {
            animateViewsForTextEntry()
        }
        
        addSubview(foregroundView)
        addSubview(placeholderLabel)
    }
    
    override open func animateViewsForTextEntry() {
        let directionOverride: CGFloat
        
        if #available(iOS 9.0, *) {
            directionOverride = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft ? -1.0 : 1.0
        } else {
            directionOverride = 1.0
        }
        
        self.togglePlaceholderTrunc(true)
        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
            self.placeholderLabel.frame.origin = CGPoint(x: self.frame.size.width * self.foregroundWidthRatio * directionOverride, y: self.placeholderInsets.y)
        }), completion: nil)
        
        UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.5, options: .beginFromCurrentState, animations: ({
            self.foregroundView.frame.origin = CGPoint(x: self.frame.size.width * self.inputEntryWidthRatio * directionOverride, y: 0)
        }), completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }
    
    open override func textFieldDidEndEditing() {
        super.textFieldDidEndEditing()
        togglePlaceholderColor(isTextEmpty: text?.isEmpty ?? true)
    }
    
    override open func animateViewsForTextDisplay() {
        if text!.isEmpty {
            self.togglePlaceholderTrunc(false)
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = self.placeholderInsets
            }), completion: nil)
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.foregroundView.frame.origin = CGPoint.zero
            }), completion: { _ in
                self.animationCompletionHandler?(.textDisplay)
            })
        }
    }
    
    private func togglePlaceholderColor(isTextEmpty empty: Bool){
        placeholderLabel.textColor = empty ? placeholderColor : tintColor
    }
    
    private func togglePlaceholderTrunc(_ trunc: Bool){
        if trunc{
            placeholderLabel.text = placeholder!.trunc(length: max_placeholder_count)
        }else{
            placeholderLabel.text = placeholder
        }
    }
    
    // MARK: - Private
    
    private func updateForegroundColor() {
        foregroundView.backgroundColor = foregroundColor
    }
    
    private let max_placeholder_count: Int = 10
    private func updatePlaceholder() {
            placeholderLabel.text = placeholder
            placeholderLabel.textColor = placeholderColor
        
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let smallerFont = UIFont(name: font.fontName, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }
    
    // MARK: - Overrides
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width * inputEntryWidthRatio, height: bounds.size.height))
        
        if #available(iOS 9.0, *) {
            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
                frame.origin = CGPoint(x: bounds.size.width - frame.size.width, y: frame.origin.y)
            }
        }
        
        return frame.insetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }
    
    
    @objc public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
