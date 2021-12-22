//
//  FaceCheckViewController.swift
//  HSB
//
//  Created by JW Moon on 2021/12/14.
//

import UIKit

fileprivate let reuseIdentifier = "FaceCheckInputCell"

class FaceCheckViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = FaceCheckViewModel()
    
    var currentInputCellType: FaceCheckInputType = .grade {
        didSet {
            inputCollectionView.reloadData()
            configureCancelButton()
            studentInfoLabel.text = viewModel.studentInfoLabelText
        }
    }
    
    private let studentInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let inputCollectionView: UICollectionView = {
            
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 50 / 2
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    private var isCancelButtonHidden: Bool {
        return currentInputCellType == .grade ? true : false
    }
    
    private var cancelButtonTitle: String {
        switch currentInputCellType {
        case .grade:
            return ""
        case .classNumber:
            return "학년 다시 선택"
        case .number:
            return "반 다시 선택"
        }
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureCancelButton()
        studentInfoLabel.text = viewModel.studentInfoLabelText
    }
    
    // MARK: - Selector
    
    @objc func cancelTapped() {
        switch currentInputCellType {
        case .grade: return
        case .classNumber:
            viewModel.grade = nil
            currentInputCellType = .grade
        case .number:
            viewModel.classNumber = nil
            viewModel.number = nil
            currentInputCellType = .classNumber
        }
    }
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        navigationItem.title = "학생 조회"
    }
    
    func configureUI() {
        view.backgroundColor = .white

        inputCollectionView.delegate = self
        inputCollectionView.dataSource = self
        inputCollectionView.register(FaceCheckInputCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(studentInfoLabel)
        studentInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        studentInfoLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        studentInfoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        studentInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        studentInfoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(inputCollectionView)
        inputCollectionView.translatesAutoresizingMaskIntoConstraints = false
        inputCollectionView.topAnchor.constraint(equalTo: studentInfoLabel.bottomAnchor, constant: 10).isActive = true
        inputCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        inputCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        inputCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func configureCancelButton() {
        cancelButton.isHidden = self.isCancelButtonHidden
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
    }
    
    func clearInputs() {
        viewModel.clearInputs()
        currentInputCellType = .grade
    }
}

extension FaceCheckViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentInputCellType {
        case .grade: return 3
        case .classNumber: return viewModel.numOfClass
        case .number: return viewModel.numOfStudent
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FaceCheckInputCell else { return UICollectionViewCell() }
        cell.inputCellType = currentInputCellType
        let cellText = viewModel.inputCellText(row: indexPath.row, type: currentInputCellType)
        cell.setCellText(cellText)
        return cell
    }
}

extension FaceCheckViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentInputCellType {
        case .grade:
            viewModel.grade = indexPath.row + 1
            studentInfoLabel.text = viewModel.studentInfoLabelText
            currentInputCellType = .classNumber
        case .classNumber:
            viewModel.classNumber = indexPath.row + 1
            studentInfoLabel.text = viewModel.studentInfoLabelText
            currentInputCellType = .number
        case .number:
            viewModel.number = indexPath.row + 1
            guard let student = viewModel.student else { return }
            let vc = StudentProfileViewController(student: student)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FaceCheckViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        var height: CGFloat
        switch currentInputCellType {
        case .grade:
            width = view.frame.width - 20
            height = view.frame.height / 6
        case .classNumber:
            width = (view.frame.width - 20 - 10) / 3
            height = width
        case .number:
            width = (view.frame.width - 20 - 20) / 5
            height = width
        }
        return CGSize(width: width, height: height)
    }
}
