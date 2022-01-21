//
//  DatePickerViewController.swift
//  HSB
//
//  Created by JW Moon on 2022/01/21.
//

import Foundation
import UIKit

class DatePickerViewController: UIViewController {
    
    // MARK: - Properties
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.minimumDate = Date()
        return picker
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePicker()
    }
    
    // MARK: - Helpers
    
    func configurePicker() {
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
