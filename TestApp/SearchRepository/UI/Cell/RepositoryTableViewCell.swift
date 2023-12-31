//
//  RepositoryTableViewCell.swift
//  TestApp
//
//  Created by Adavan Ayyappan on 16/12/23.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    static let identifier = "repositorycell"
    lazy var namelbl: UILabel = {
        let namelbl = UILabel()
        namelbl.textAlignment = .left
        namelbl.font = UIFont.boldSystemFont(ofSize: 18)
        namelbl.translatesAutoresizingMaskIntoConstraints = false
        return namelbl
    }()
    lazy var starlbl: UILabel = {
        let starlbl = UILabel()
        starlbl.textAlignment = .left
        starlbl.textColor = .gray
        starlbl.translatesAutoresizingMaskIntoConstraints = false
        return starlbl
    }()
    lazy private var pointer: UIImageView = {
        let pointer = UIImageView()
        let arrow = UIImage(systemName: "chevron.right")
        pointer.tintColor = .darkGray
        pointer.image = arrow
        pointer.translatesAutoresizingMaskIntoConstraints = false
        return pointer
    }()
    lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .systemGray5
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        return backView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.frame = CGRect(x: 20, y: 6, width: contentView.frame.size.width - 40, height: 110)
        
        NSLayoutConstraint.activate([
            pointer.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0),
            pointer.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            
            namelbl.trailingAnchor.constraint(equalTo: pointer.leadingAnchor, constant: -10),
            namelbl.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            namelbl.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: -15),
            
            starlbl.trailingAnchor.constraint(equalTo: pointer.leadingAnchor, constant: -10),
            starlbl.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            starlbl.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 10)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backView)
        backView.addSubview(namelbl)
        backView.addSubview(starlbl)
        backView.addSubview(pointer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
