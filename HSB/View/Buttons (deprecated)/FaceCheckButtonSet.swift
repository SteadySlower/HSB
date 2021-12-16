////
////  FaceCheckButton.swift
////  HSB
////
////  Created by JW Moon on 2021/12/14.
////
//
//import Foundation
//import UIKit
//
//enum FaceCheckButtonType {
//    case grade, classNumber, number
//    
//    func buttonTitle(num: Int) -> String {
//        switch self {
//        case .grade: return "\(num)학년"
//        case .classNumber: return "\(num)반"
//        case .number: return "\(num)번"
//        }
//    }
//}
//
//protocol FaceCheckButtonDelegate {
//    func buttonTapped(sender: FaceCheckButton)
//}
//
//class FaceCheckButton: UIButton {
//    
//    // MARK: - Properties
//    
//    let num: Int
//    let faceCheckButtonType: FaceCheckButtonType
//    
//    var delegate: FaceCheckButtonDelegate?
//    
//    // MARK: - LifeCycle
//    
//    init(frame: CGRect, num: Int, type: FaceCheckButtonType) {
//        self.num = num
//        self.faceCheckButtonType = type
//        super.init(frame: frame)
//        
//        //✅ 버튼 모양
//        let title = faceCheckButtonType.buttonTitle(num: num)
//        self.setTitleColor(.black, for: .normal)
//        self.setTitle(title, for: .normal)
//        
//        self.backgroundColor = .green
//        self.layer.cornerRadius = 30
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 3
//        self.titleLabel?.font = .systemFont(ofSize: 50)
//
//        self.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - selector
//    
//    @objc func buttonTapped(sender: FaceCheckButton) {
//        delegate?.buttonTapped(sender: sender)
//    }
//}
//
//protocol FaceCheckButtonSetDelegate {
//    func buttonTapped(sender: FaceCheckButton)
//}
//
//class FaceCheckButtonSet: UIView {
//    
//    let faceCheckButtonsType: FaceCheckButtonType
//    var delegate: FaceCheckButtonSetDelegate?
//    
//    init(frame: CGRect, type: FaceCheckButtonType) {
//        self.faceCheckButtonsType = type
//        super.init(frame: frame)
//        configureGradeButtons()
//    }
//    
////    override func layoutSubviews() {
////        configureGradeButtons()
////    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureGradeButtons() {
//        var buttons = [FaceCheckButton]()
//        
//        for num in (1...3) {
//            let button = FaceCheckButton(frame: .zero, num: num, type: .grade)
//            button.delegate = self
//            buttons.append(button)
//        }
//        
//        let stack = UIStackView(arrangedSubviews: buttons)
//        stack.axis = .vertical
//        stack.spacing = 30
//        stack.distribution = .fillEqually
//        
//        addSubview(stack)
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//    }
//    
//    func configureClassNumberButtons() {
//        var columns = [UIStackView]()
//        
//        for num1 in (0...2) {
//            var buttons = [FaceCheckButton]()
//            for num2 in (1...3) {
//                let button = FaceCheckButton(frame: .zero, num: num1 * 3 + num2, type: .classNumber)
//                button.delegate = self
//                buttons.append(button)
//            }
//            let row = UIStackView(arrangedSubviews: buttons)
//            row.axis = .horizontal
//            row.spacing = 10
//            row.distribution = .fillEqually
//            
//            columns.append(row)
//        }
//        
//        let stack = UIStackView(arrangedSubviews: columns)
//        stack.axis = .vertical
//        stack.spacing = 10
//        stack.distribution = .fillEqually
//        
//        addSubview(stack)
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
//        stack.heightAnchor.constraint(equalToConstant: self.frame.width).isActive = true
//        stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        stack.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
//    }
//}
//
//extension FaceCheckButtonSet: FaceCheckButtonDelegate {
//    func buttonTapped(sender: FaceCheckButton) {
//        delegate?.buttonTapped(sender: sender)
//    }
//}
