//
//  HeaderFeedTableViewCell.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 09/03/2024.
//

import UIKit

class HeaderFeedTableViewCell: UITableViewCell {

    static let indentifier = "HeaderFeedTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configuareModel(){
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
