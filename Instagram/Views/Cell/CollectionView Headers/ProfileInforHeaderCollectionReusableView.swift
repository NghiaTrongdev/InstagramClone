//
//  ProfileInforCollectionReusableView.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 11/03/2024.
//

import UIKit
protocol ProfileInforHeaderCollectionReusableViewDelegate : AnyObject {
    func profileheaderDidTapPostButton(_ header : ProfileInforHeaderCollectionReusableView )
    func profileheaderDidTapFollowingButton(_ header : ProfileInforHeaderCollectionReusableView )
    func profileheaderDidTapFollowersButton(_ header : ProfileInforHeaderCollectionReusableView )
    func profileheaderDidTapEditButton(_ header : ProfileInforHeaderCollectionReusableView )
}
class ProfileInforHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInforCollectionReusableView"
    
    public weak var delegate : ProfileInforHeaderCollectionReusableViewDelegate?
    
    public let profileImageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .red
        img.layer.masksToBounds = true
        return img
    }()
    
    private let postButton : UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followingButton : UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let followerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Follower", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let editProfileButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let bioLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.text = "This is the first account"
        return label
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.text = "Trong nghia"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonAction()
        clipsToBounds = true
        backgroundColor = .systemBackground
        
    }
    private func addSubviews(){
        addSubview(profileImageView)
        addSubview(postButton)
        addSubview(followerButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(bioLabel)
        addSubview(nameLabel)
        
        
    }
    private func addButtonAction()
    {
        postButton.addTarget(self, action: #selector(didtapPostButton), for: .touchUpInside)
        
        followingButton.addTarget(self, action: #selector(didtapFollowingButton), for: .touchUpInside)
        
        followerButton.addTarget(self, action: #selector(didtapFollowerButton), for: .touchUpInside)
        
        editProfileButton.addTarget(self, action: #selector(didtapEditProfileButton), for: .touchUpInside)
    }
    @objc private func didtapPostButton(){
        delegate?.profileheaderDidTapPostButton(self)
    }
    @objc private func didtapFollowingButton(){
        delegate?.profileheaderDidTapFollowersButton(self)
    }
    @objc private func didtapFollowerButton(){
        delegate?.profileheaderDidTapFollowingButton(self)
        
    }
    @objc private func didtapEditProfileButton(){
        delegate?.profileheaderDidTapEditButton(self)
       
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profileImageSize = width / 4
        let buttonSize = profileImageSize / 2
        let countButtonWidth = (width - 10 - profileImageSize) / 3
        
        profileImageView.frame = CGRect(x: 5, y: 5, width: profileImageSize, height: profileImageSize).integral
        
        profileImageView.layer.cornerRadius = profileImageSize / 2.0
        
        postButton.frame = CGRect(x: profileImageView.right, y: 5, width: countButtonWidth, height: buttonSize).integral
        
        followerButton.frame = CGRect(x: postButton.right, y: 5, width: countButtonWidth, height: buttonSize).integral
        
        followingButton.frame = CGRect(x: followerButton.right, y: 5, width: countButtonWidth, height: buttonSize).integral
        
        editProfileButton.frame = CGRect(x: profileImageView.right, y: 5 + buttonSize, width: countButtonWidth*3, height: buttonSize).integral
        
        let bioheight = bioLabel.sizeThatFits(frame.size)
        
        nameLabel.frame = CGRect(x: 5, y: profileImageView.bottom, width: width-10, height:50 ).integral
        
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom + 5, width: width-10, height:bioheight.height ).integral
        
    }
}
