//
//  CSTextInput.swift
//  ComplainceSDK
//
//  Created by Mayowa Olunuga on 15/08/2022.
//

import UIKit

class CSTextInput: UIView {
    private let inputLabel: CSLabel
    private let stackView: UIStackView
    private var label: String = ""
    private var placeHolder: String?
    
    public var text: String = "" {
        didSet {
            setContent(text: text)
        }
    }
    public var textField: CSInputField
    
    public init(style: InputStyle, label: String, text: String?, placeHolder: String?) {
        textField = CSInputField(style: style)
        inputLabel = CSLabel(text: "Label", style: style.labelStyle)
        stackView = UIStackView(arrangedSubviews: [inputLabel, textField])
        self.text = text ?? ""
        self.label = label
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setContent(text: text)
        setStyle(style)
    }
    
    private func setupViews(){
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        stackView.axis = .vertical
        addSubview(stackView)
    }
    
    private func setupConstraints(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.fillSuperview()
    }
    private func setStyle(_ style: InputStyle){
        textField.layoutIfNeeded()
        textField.textColor = style.textStyle.color
        textField.tintColor = style.textStyle.color

        
        stackView.spacing = style.labelSpacing
    }
    
    @objc private func textFieldDidChange(){
        updateState(text: textField.text)
    }
    
    @objc private func cleanTextField(){
        updateState(text: "")
    }
    
    private func updateState(text: String?){
        setContent(text: text)
    }
    
    private func setContent(text: String?){
        textField.text = text
        textField.placeholder = placeHolder
        inputLabel.text = label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CSTextInput: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateState(text: textField.text)
    }
}

class CSInputField: UITextField {

    // MARK: Lifecycle

    init(style: InputStyle) {
        self.style = style
        super.init(frame: .zero)
        tintColor = .yellow
        styleBorder()
        update()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    final override var attributedPlaceholder: NSAttributedString? {
        get {
            return super.attributedPlaceholder
        }
        set {
            preconditionFailure("Use `placeholder` instead.")
        }
    }

    final override var bounds: CGRect {
        didSet {
            styleBorderRadius()
        }
    }

    final override var placeholder: String? {
        didSet {
            update()
        }
    }

    final var style: InputStyle {
        didSet {
            styleBorder()
            styleBorderRadius()

            update()
        }
    }

    final override var textColor: UIColor? {
        didSet {
            update()
        }
    }

    @discardableResult
    override func becomeFirstResponder() -> Bool {
        defer {
            styleBorder()
        }

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        defer {
            styleBorder()
        }

        return super.resignFirstResponder()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(
            dx: style.horizontalContentInset,
            dy: style.verticalContentInset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(
            dx: style.horizontalContentInset,
            dy: style.verticalContentInset)
    }

    // MARK: Private

    private func styleBorder() {
        let borderStyle: CSBorderStyle

        if isFirstResponder {
            borderStyle = style.borderStyleActive
        } else {
            borderStyle = style.borderStyle
        }

        layer.borderColor = borderStyle.color?.cgColor
        layer.borderWidth = borderStyle.width
    }

    private func styleBorderRadius() {
        layer.cornerRadius = style.borderRadius
    }

    private func update() {
        for attribute in style.textStyle.attributes(color: textColor) {
            defaultTextAttributes[attribute.key] = attribute.value
        }

        super.attributedPlaceholder = placeholder.flatMap { placeholder in
            NSAttributedString(
                string: placeholder,
                attributes: style.textStylePlaceholder.attributes(
                    color: style.textColorPlaceholder))
        }
    }
}
