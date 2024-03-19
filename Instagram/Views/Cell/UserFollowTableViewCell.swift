//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 15/03/2024.
//

import UIKit
protocol UserFollowTableViewCellDelegate : AnyObject {
    func didTapFollowUnfollowButton(with model : UserRelations)
}

class UserFollowTableViewCell: UITableViewCell {
    
    public static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate :UserFollowTableViewCellDelegate?
    
    private var model : UserRelations?
    
    private let imageProfile : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Nghia"
        return label
    }()
    
    private let userLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@Nghia"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButotn : UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    public func configuare(with model : UserRelations){
        self.model = model
        nameLabel.text = model.name
        userLabel.text = model.username
        switch model.type {
        case .following:
            followButotn.setTitle("Unfollow", for: .normal)
            followButotn.setTitleColor(.label, for: .normal)
            followButotn.backgroundColor = .systemBackground
            followButotn.layer.borderWidth = 1
            followButotn.layer.borderColor = UIColor.label.cgColor
        case .not_follow:
            followButotn.setTitle("Follow", for: .normal)
            followButotn.setTitleColor(.white, for: .normal)
            followButotn.backgroundColor = .link
            followButotn.layer.borderWidth = 0
            
        }
        
    }
    
    @objc public func didTapFollowUnfollowButton(){
        guard let  model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(with: model)
    }
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(imageProfile)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userLabel)
        contentView.addSubview(followButotn)
        selectionStyle = .none
        followButotn.addTarget(self,
                               action: #selector(didTapFollowUnfollowButton),
                               for: .touchUpInside)
        

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageProfile.image = nil
        userLabel.text = nil
        nameLabel.text = nil
        followButotn.setTitle(nil, for: .normal)
        followButotn.layer.borderWidth = 0
        followButotn.backgroundColor = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageProfile.frame = CGRect(x: 3,
                                    y: 3,
                                    width:contentView.height - 6 ,
                                    height: contentView.height - 6)
        imageProfile.layer.cornerRadius = imageProfile.height / 2.0
        
        let labelHeight = contentView.height / 2.0
        
        let buttonwidth = contentView.width > 500 ? 220.0 : contentView.width / 3.0
        followButotn.frame = CGRect(x: contentView.width - 5 - buttonwidth,
                                    y: (contentView.height - followButotn.height)/2,
                                    width: buttonwidth,
                                    height: 40)
        
        nameLabel.frame = CGRect(x: imageProfile.right + 5,
                                 y: 0,
                                 width: contentView.width - 3 - imageProfile.width - buttonwidth,
                                 height: labelHeight)
        
        userLabel.frame = CGRect(x: imageProfile.right + 5,
                                 y: nameLabel.bottom ,
                                 width: contentView.width - 3 - imageProfile.width - buttonwidth,
                                 height: labelHeight)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
