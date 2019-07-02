//
//  AddNoteViewController.swift
//  deathNote_app
//
//  Created by Daniil KOZYR on 7/1/19.
//  Copyright © 2019 Daniil KOZYR. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    var delegate: AddNewDeathNoteDelegate?
    private let datePicker = UIDatePicker()
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy HH:mm"
        return formatter
    }
    
    @IBOutlet weak var descriptionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameField: UITextField! {
        didSet {
            nameField.delegate = self
        }
    }
    @IBOutlet weak var descriptionView: UITextView! {
        didSet {
            descriptionView.delegate = self
        }
    }
    @IBOutlet weak var dateField: UITextField! {
        didSet {
            dateField.inputView = datePicker
        }
    }
    @IBAction func onTouchDoneButton(_ sender: UIBarButtonItem) {
        guard let name = nameField.text, !name.isEmpty else {
            showAlert(title: "Error", message: "Fill Name Field")
            return
        }
        guard var description = descriptionView.text else {
            return
        }
        guard let date = dateField.text else {
            return
        }
        
        if description == "••••••••••" {
            description = "🧟‍♂️"
        }
        
        let newDeathNote = DeathNote(name: name, description: description, time: date)
        delegate?.onCreatedNew(note: newDeathNote)
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.inputAccessoryView = createKeyboardToolbar()
        dateField.inputAccessoryView = createKeyboardToolbar()
        descriptionView.inputAccessoryView = createKeyboardToolbar()
        
        descriptionView.text = "••••••••••"
        descriptionView.textColor = .lightGray
        descriptionView.textContainer.maximumNumberOfLines = 5

        dateField.tintColor = .clear
        dateField.text = formatter.string(from: Date())
        datePicker.locale = Locale(identifier: "en_GB")
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(AddNoteViewController
            .datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
    }
    
    @objc private func doneClicked() {
        view.endEditing(true)
    }
    
    @objc private func datePickerValueChanged(sender: UIDatePicker) {
        dateField.text = formatter.string(from: sender.date)
    }
    
    private func createKeyboardToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            print("yo" )
        }
        alert.addAction(actionOk)
        present(alert, animated: true, completion: nil)
    }
    
}


extension AddNoteViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 30
    }
}

extension AddNoteViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return range.location < 200
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textView.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "••••••••••"
            textView.textColor = .lightGray
        }
    }
}
