//
//  ViewController.swift
//  hashTag
//
//  Created by Reza Kashkoul on 25/4/1401 AP.
//

import UIKit

class ViewController: UIViewController {
    
    var textField: UITextField!
    var stickerView: UIView!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField?.delegate = self
        setupUI()
    }
    
    func setupUI() {
        title = "HASHTAG!"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSticker))
        view.backgroundColor = UIColor.lightGray
    }
    
    @objc private func addSticker() {
        
        if stickerView == nil {
            addStickerView()
            view.layoutIfNeeded()
            setupPanGesture()
            //            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
        }
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        stickerView.addGestureRecognizer(panGesture)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc private func panGesture(sender: UIPanGestureRecognizer){
        let point = sender.location(in: view)
        let panGesture = sender.view
        panGesture?.center = point
        print(point)
        textField.resignFirstResponder()
        //        textField.isEnabled = false
    }
    
}

//MARK: - TextField functions
extension ViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(sender: UITextField) {
        let width = getTextFieldWidth(text: sender.text!)
        textField.frame.size.width = width
        
        let newWidth = min(label.frame.width + textField.bounds.width, UIScreen.main.bounds.width)
        let newFrame = CGRect(x: 0, y: 0, width: newWidth, height: stickerView.frame.height)
        stickerView.frame = newFrame
        stickerView.center = view.center
        view.layoutSubviews()
        stickerView.layoutIfNeeded()
    }
    
    @objc func textFieldShouldReturn(sender: UITextField) {
        textField.resignFirstResponder()
    }
    
}

//MARK: - Setup Views
extension ViewController {
    
    private func getTextFieldWidth(text: String) -> CGFloat {
        textField.text = text
        textField.sizeToFit()
        return textField.frame.size.width
    }
    
    private func addStickerView() {
        let centerScreenWidth = UIScreen.main.bounds.width/2
        let centerScreenHeight = UIScreen.main.bounds.height/2
        let height: CGFloat = 60
        let width: CGFloat = 100
        stickerView =  UIView(frame: CGRect(x: centerScreenWidth-width/2, y: centerScreenHeight-height/2, width: width, height: height))
        stickerView.backgroundColor = .blue
        
        view.addSubview(stickerView)
        addTextField()
        addLabel()
        stickerView.addSubview(textField)
        stickerView.addSubview(label)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: textField!, attribute: .leading, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField!, attribute: .trailing, relatedBy: .equal, toItem: stickerView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField!, attribute: .top, relatedBy: .equal, toItem: stickerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: textField!, attribute: .bottom, relatedBy: .equal, toItem: stickerView, attribute: .bottom, multiplier: 1, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: label!, attribute: .leading, relatedBy: .equal, toItem: stickerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label!, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label!, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: label!, attribute: .bottom, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    private func addLabel() {
        label =  UILabel(frame: CGRect(x: 0, y: 0, width: stickerView.frame.height, height: stickerView.frame.height))
        label.text = "#"
        label.font = UIFont.systemFont(ofSize: 25)
        //        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
    }
    
    private func addTextField() {
        textField =  UITextField(frame: CGRect(x: 0, y: 0, width: stickerView.frame.height, height: stickerView.frame.height))
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.minimumFontSize = 12
        textField.placeholder = "HASHTAG"
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = .never
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldShouldReturn(sender:)), for: .primaryActionTriggered)
    }
    
}
