//
//  UserViewCell.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    private var nameLabel = UILabel()
    private var emailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        
        emailLabel.font = .systemFont(ofSize: 17, weight: .regular)
        emailLabel.textColor = .secondaryLabel
        emailLabel.numberOfLines = 1
        emailLabel.textAlignment = .left
        
        [nameLabel, emailLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -5),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
    }
    
    public func configure(with user: User) {
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
    }
    
}
