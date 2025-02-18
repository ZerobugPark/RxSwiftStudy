//
//  SimpleTableViewCell.swift
//  RxSwiftStudy
//
//  Created by youngkyun park on 2/18/25.
//

import UIKit


class SimpleTableViewCell: UITableViewCell {

    static let id = "SimpleTableViewCell"
    
    let titleLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        configure()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    private func configure() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(8)
        }
        

        titleLabel.font = .systemFont(ofSize: 18)
    }
    

}
