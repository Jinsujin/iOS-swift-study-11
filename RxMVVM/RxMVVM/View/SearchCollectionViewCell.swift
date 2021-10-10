//
//  SearchCollectionViewCell.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/08.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    private let repoTitle: UILabel = {
        $0.font = .systemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private let repoDescription: UILabel = {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
        return $0
    }(UILabel())
    
    private let repoStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(repoStackView)
        repoStackView.addArrangedSubview(repoTitle)
        repoStackView.addArrangedSubview(repoDescription)
        
        repoStackView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView).offset(20)
            $0.bottom.trailing.equalTo(contentView).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(text: RepositoryItemModel) {
        repoTitle.text = text.fullName
        repoDescription.text = text.description
    }
}
