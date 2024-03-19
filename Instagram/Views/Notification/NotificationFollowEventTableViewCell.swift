//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 15/03/2024.
//

import UIKit
protocol NotificationFollowEventTableViewCellDelegate : AnyObject {
    func didTapFollowUnfollowButton(with model : UserNotification)
}
class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    public weak var delegate :NotificationFollowEventTableViewCellDelegate?
    
    private var model : UserNotification?
    
    private let profileImage : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Follow "
        label.numberOfLines = 0
        return label
    }()
    private let followButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configuareForFollow()
    }
    @objc func didTapFollowButton()
    {
        guard let model = model else  {
            return
        }
        delegate?.didTapFollowUnfollowButton(with: model)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    public func configuare(with model : UserNotification){
        self.model = model
        switch model.type {
        case .like(_):
           break
            
        case .follow(let state):
            switch state{
            case .following:
                configuareForFollow()
            case .not_follow:
                followButton.setTitle("Follow", for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link
                followButton.setTitleColor(.white, for: .normal)
                
            }
        }
        nameLabel.text = model.text
        profileImage.sd_setImage(with: model.user.profileImage, completed: nil)
    
    }
    private func configuareForFollow(){
        followButton.setTitle("Unfollow", for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        followButton.setTitleColor(.label, for: .normal)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        nameLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImage.layer.cornerRadius = profileImage.height/2
        let buttonHeight : CGFloat = 40
        let size :CGFloat = 100
        followButton.frame = CGRect(x: contentView.width - size - 5, y: (contentView.height - buttonHeight) / 2, width: size, height:  buttonHeight)
        nameLabel.frame = CGRect(x: profileImage.right + 5,
                                y: 0, width: contentView.width - profileImage.width - 16,
                                height: contentView.height)
    }
    

}
