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
        addTextField()
        setupUI()
        setupPanGesture()
    }
    
    func setupUI() {
        title = "Hashtaged!"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.lightGray
    }
    
    func addTextField() {
        let centerScreenWidth = UIScreen.main.bounds.width/2
        let centerScreenHeight = UIScreen.main.bounds.height/2
        let textFieldHeight: CGFloat = 60
        let textFieldWidth: CGFloat = 250
        textField =  UITextField(frame: CGRect(x: centerScreenWidth-textFieldWidth/2, y: centerScreenHeight-textFieldHeight/2, width: textFieldWidth, height: textFieldHeight))
        textField.placeholder = "#"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 40)
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        view.addSubview(textField)
    }
    
    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        self.textField.addGestureRecognizer(panGesture)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func panGesture(sender: UIPanGestureRecognizer){
        let point = sender.location(in: view)
        let panGesture = sender.view
        panGesture?.center = point
        print(point)
        textField.resignFirstResponder()
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(sender: UITextField) {
        print("hiii")
    }
    
}
