//
//  File.swift
//  HSB
//
//  Created by JW Moon on 2021/12/15.
//

import UIKit

enum FaceCheckInputType {
    case grade, classNumber, number
    
    var cellTitleFontSize: UIFont {
        switch self {
        case .grade:
            return UIFont.systemFont(ofSize: 70)
        case .classNumber:
            return UIFont.systemFont(ofSize: 50)
        case .number:
            return UIFont.systemFont(ofSize: 30)
        }
    }
    
    var cellColor: UIColor {
        switch self {
        case .grade:
            return .green
        case .classNumber:
            return .yellow
        case .number:
            return .cyan
        }
    }
}

class FaceCheckInputCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var inputCellType: FaceCheckInputType? {
        didSet {
            inputCellLabel.font = inputCellType?.cellTitleFontSize
            backgroundColor = inputCellType?.cellColor
        }
    }
    
    private let inputCellLabel = UILabel()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        
        addSubview(inputCellLabel)
        inputCellLabel.translatesAutoresizingMaskIntoConstraints = false
        inputCellLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        inputCellLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setCellText(_ text: String) {
        inputCellLabel.text = text
    }
    
}
