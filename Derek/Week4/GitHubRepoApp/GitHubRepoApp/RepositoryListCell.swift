//
//  RepositoryListCell.swift
//  GitHubRepoApp
//
//  Created by Sh Hong on 2021/11/18.
//

import UIKit
import SnapKit

class RepositoryListCell: UITableViewCell {
    
    // MARK: - Properties
    var repository: Repository? 
    
    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    let starImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
    }
    
    let starLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
    }
    
    let languageLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .gray
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        [
            nameLabel, descriptionLabel,
            starImageView, starLabel, languageLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fetchUI()
    }

    func fetchUI() {
        guard let repository = repository else { return }
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        starLabel.text = String(repository.stargazersCount)
        languageLabel.text = repository.language
    }
    
    func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(3)
            make.leading.equalTo(descriptionLabel)
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview().inset(18)
        }
        
        starLabel.snp.makeConstraints { make in
            make.centerX.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(starLabel)
            make.leading.equalTo(starLabel.snp.trailing).offset(12)
        }
    }
}
