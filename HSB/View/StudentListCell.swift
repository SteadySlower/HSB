//
//  StudentListCell.swift
//  HSB
//
//  Created by JW Moon on 2021/12/17.
//

import UIKit

protocol StudentListCellDelegate: AnyObject {
    func deleteButtonTapped(in cell: StudentListCell)
}

class StudentListCell: UITableViewCell {
    
    // MARK: - Properties

    var guidance: Guidance? {
        didSet {
            self.viewModel = StudentListCellViewModel(guidance: guidance!)
            configure()
        }
    }
    
    var delegate: StudentListCellDelegate?
    
    var viewModel: StudentListCellViewModel?
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iv.layer.cornerRadius = 48 / 2
        return iv
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let reasonLabel = UILabel()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeStyle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    // MARK: - Selector
    
    @objc func deleteButtonTapped() {
        delegate?.deleteButtonTapped(in: self)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        contentView.backgroundColor = UIColor.init(red: 255/256, green: 252/256, blue: 220/256, alpha: 1)
        contentView.layer.cornerRadius = (100 - 10) / 4
        
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        contentView.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        contentView.addSubview(reasonLabel)
        reasonLabel.translatesAutoresizingMaskIntoConstraints = false
        reasonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20).isActive = true
        reasonLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true
        reasonLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        
    }
    
    func configure() {
        infoLabel.text = viewModel?.infoLabelText
        reasonLabel.attributedText = viewModel?.reasonAttributedText
        profileImageView.image = viewModel?.profileImage
    }
}
