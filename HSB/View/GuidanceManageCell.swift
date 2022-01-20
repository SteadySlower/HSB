//
//  GuidanceManageCell.swift
//  HSB
//
//  Created by JW Moon on 2022/01/20.
//

import Foundation
import UIKit

protocol GuidanceManageCellDelegate: AnyObject {
    func completeButtonTapped(in cell: GuidanceManageCell)
    func delayButtonTapped(in cell: GuidanceManageCell)
}

class GuidanceManageCell: UITableViewCell {
    
    // MARK: - Properties

    var guidance: Guidance? {
        didSet {
            self.viewModel = GuidanceManageCellViewModel(guidance: guidance!)
            configure()
        }
    }
    
    var delegate: GuidanceManageCellDelegate?
    
    var viewModel: GuidanceManageCellViewModel?
    
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
    
    let scheduleLabel = UILabel()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        // 버튼 이미지 크기 버튼 크기에 맞추는 코드
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let delayButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(systemName: "forward.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(delayButtonTapped), for: .touchUpInside)
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
    
    @objc func completeButtonTapped() {
        delegate?.completeButtonTapped(in: self)
    }
    
    @objc func delayButtonTapped() {
        delegate?.delayButtonTapped(in: self)
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
        
        contentView.addSubview(scheduleLabel)
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        scheduleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20).isActive = true
        scheduleLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20).isActive = true
        scheduleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        contentView.addSubview(delayButton)
        delayButton.translatesAutoresizingMaskIntoConstraints = false
        delayButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        delayButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true

        
        contentView.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        completeButton.rightAnchor.constraint(equalTo: delayButton.leftAnchor, constant: -10).isActive = true
    }
    
    func configure() {
        infoLabel.text = viewModel?.infoLabelText
        scheduleLabel.attributedText = viewModel?.scheduleAttributedText
        profileImageView.image = viewModel?.profileImage
    }
}
