//
//  StudentProfileViewController.swift
//  HSB
//
//  Created by JW Moon on 2021/12/16.
//

import UIKit

class StudentProfileViewController: UIViewController {
    
    // MARK: - Properties

    let viewModel: StudentProfileViewModel
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 50)
        button.backgroundColor = .green
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("처음\n으로", for: .normal)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.font = .systemFont(ofSize: 50)
        button.backgroundColor = .red
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var actionSheet: UIAlertController = {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        GuidanceReason.allCases.forEach { reason in
            let action = UIAlertAction(title: reason.description, style: .default) { _ in
                self.actionSheetTapped(reason: reason)
            }
            actionSheet.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        actionSheet.addAction(cancel)
        
        return actionSheet
    }()
    
    lazy var otherReasonAlert: UIAlertController = {
        let alert = UIAlertController(title: "기타 사유 입력", message: nil, preferredStyle: .alert)
        alert.addTextField { tf in
            tf.placeholder = "직접 입력하세요."
        }
        let register = UIAlertAction(title: "등록", style: .default) { _ in
            let detail = alert.textFields?[0].text
            let reason = GuidanceReason.others(detail: detail)
            self.actionSheetTapped(reason: reason)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(register)
        alert.addAction(cancel)
        return alert
    }()
    
    // MARK: - Lifecycle
    
    init(student: Student) {
        self.viewModel = StudentProfileViewModel(student: student)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
        configure()
    }
    
    // MARK: - Selector
    
    @objc func registerButtonTapped() {
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        guard let vc = navigationController?.viewControllers[0] as? FaceCheckViewController else { return }
        vc.clearInputs()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func actionSheetTapped(reason: GuidanceReason) {
        switch reason {
        case .others(let detail):
            if detail == nil {
                self.present(self.otherReasonAlert, animated: true, completion: nil)
                return
            } else {
                self.viewModel.registerGuidance(reason: reason)
                cancelButtonTapped()
            }
        default:
            self.viewModel.registerGuidance(reason: reason)
            cancelButtonTapped()
        }
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "학생 정보"
        let backButton = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewWidth = view.frame.width - 40
        profileImageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        profileImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        profileImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        let buttonWidth = (view.frame.width - 30) / 2
        
        view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        registerButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        cancelButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func configure() {
        infoLabel.text = viewModel.infoLabelText
        nameLabel.text = viewModel.nameLabelText
        profileImageView.image = viewModel.profileImage
    }
}
