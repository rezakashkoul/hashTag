//
//  ViewController.swift
//  hashTag
//
//  Created by Reza Kashkoul on 25/4/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField?.delegate = self
        setupUI()
    }
    
    func setupUI() {
        title = "Hashtaged!"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSticker))
        view.backgroundColor = UIColor.lightGray
    }
    
    @objc private func addSticker() {
        addTextField()
        self.view.layoutIfNeeded()
        setupPanGesture()
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        self.textField.addGestureRecognizer(panGesture)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc private func panGesture(sender: UIPanGestureRecognizer){
        let point = sender.location(in: view)
        let panGesture = sender.view
        panGesture?.center = point
        print(point)
        textField.resignFirstResponder()
    }
    
}

//MARK: - TextField functions
extension ViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(sender: UITextField) {
        let width = getTextFieldWidth(text: sender.text!)
        textField.frame.size.width = width
        self.view.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    @objc func textFieldShouldReturn(sender: UITextField) {
        textField.resignFirstResponder()
    }
    
    private func getTextFieldWidth(text: String) -> CGFloat {
        textField.text = text
        textField.sizeToFit()
        return textField.frame.size.width
    }
    
    private func addTextField() {
        let centerScreenWidth = UIScreen.main.bounds.width/2
        let centerScreenHeight = UIScreen.main.bounds.height/2
        let textFieldHeight: CGFloat = 60
        let textFieldWidth: CGFloat = 100
        textField =  UITextField(frame: CGRect(x: centerScreenWidth-textFieldWidth/2, y: centerScreenHeight-textFieldHeight/2, width: textFieldWidth, height: textFieldHeight))
        textField.placeholder = "#"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = .never
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldShouldReturn(sender:)), for: .primaryActionTriggered)
        view.addSubview(textField)
    }
    
}
