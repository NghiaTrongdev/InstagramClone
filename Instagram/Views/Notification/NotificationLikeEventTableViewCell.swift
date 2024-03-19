//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 15/03/2024.
//
import SDWebImage
import UIKit

protocol NotificationLikeEventTableViewCellDelegate : AnyObject {
    func didTapRelatedPostButton(model : UserNotification)
}
class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    public weak var delegate :NotificationLikeEventTableViewCellDelegate?
    
    private var model : UserNotification?
    
    private let profileImage : UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.backgroundColor = .tertiarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Like your image"
        label.numberOfLines = 0
        return label
    }()
    private let postButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    @objc private func didTapPostButton()
    {
        guard let model = model  else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configuare(with model : UserNotification){
        self.model = model
        switch model.type {
        case .like(let post):
            
            let thumnail = post.thumnailImage
            guard !thumnail.absoluteString.contains("google.com") else {return}
            postButton.setBackgroundImage(UIImage(named: "test"), for: .normal)
            
        case .follow:
            break
        }
        nameLabel.text = model.text
        profileImage.sd_setImage(with: model.user.profileImage, completed: nil)
    
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        postButton.setTitle(nil, for: .normal)
        postButton.backgroundColor = nil
        postButton.layer.borderWidth = 0
        nameLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImage.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImage.layer.cornerRadius = profileImage.height/2
        
        let size = contentView.height - 4
        postButton.frame = CGRect(x: contentView.width - size - 5, y: 2, width: size, height: size)
        nameLabel.frame = CGRect(x: profileImage.right + 5,
                                y: 0, width: contentView.width - profileImage.width - 16,
                                height: contentView.height)
    }
    

}

