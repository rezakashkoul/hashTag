//
//  Extension.swift
//  hashTag
//
//  Created by Reza Kashkoul on 25/4/1401 AP.
//

import UIKit

extension UITextField {
    
    func addInputAccessory(textFields: [UITextField?], dismissible: Bool = true, isPreviousNextEnabled: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            //            let customFont = UIFont.ewano_Medium(size: 16)
            toolbar.sizeToFit()
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "close", style: .plain, target: nil, action: nil)
            //            doneButton.tintColor = .brandBrown
            //            doneButton.setTitleTextAttributes([ NSAttributedString.Key.font: customFont], for: UIControl.State.normal)
            doneButton.target = textFields[index]
            doneButton.action = #selector(UITextField.resignFirstResponder)
            
            var items = [UIBarButtonItem]()
            if isPreviousNextEnabled {
                let previousButton = UIBarButtonItem(title: "before", style: .plain, target: nil, action: nil)
                //                previousButton.tintColor = .brandGreen
                //                previousButton.setTitleTextAttributes([ NSAttributedString.Key.font: customFont], for: UIControl.State.normal)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                
                let nextButton = UIBarButtonItem(title: "next", style: .plain, target: nil, action: nil)
                //                nextButton.tintColor = .brandGreen
                //                nextButton.setTitleTextAttributes([ NSAttributedString.Key.font: customFont], for: UIControl.State.normal)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
            } else {
                items = [spacer, doneButton]
            }
            
            toolbar.setItems(items, animated: false)
            textField?.inputAccessoryView = toolbar
        }
    }
}
