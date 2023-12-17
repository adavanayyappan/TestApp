//
//  RepositoryDetailViewCell.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 17/12/23.
//

import UIKit

class RepositoryDetailViewCell: UITableViewCell {

    static let identifier = "repositorydetailviewcell"
    
    lazy var contributeName: UILabel = {
        let commitAuthorName = UILabel()
        commitAuthorName.textAlignment = .left
        commitAuthorName.font = UIFont.boldSystemFont(ofSize: 18)
        commitAuthorName.textColor = .systemBlue
        commitAuthorName.numberOfLines = 0
        commitAuthorName.adjustsFontSizeToFitWidth = true
        commitAuthorName.minimumScaleFactor = 10
        commitAuthorName.clipsToBounds = true
        commitAuthorName.translatesAutoresizingMaskIntoConstraints = false
        return commitAuthorName
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            contributeName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contributeName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            contributeName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            contributeName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contributeName)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
