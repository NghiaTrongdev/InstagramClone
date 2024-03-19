//
//  ProfileTabCollectionReusableView.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 11/03/2024.
//

import UIKit
protocol ProfileTabCollectionReusableViewDelegate : AnyObject {
    func didtappedGridButton()
    func didtappedTaggedButton()
}
class ProfileTabCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabCollectionReusableView"
    
    public weak var delegate : ProfileTabCollectionReusableViewDelegate?
    
    struct Constants {
        static let padding:CGFloat = 8
    }
    private let gridButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        button.tintColor =  .systemBlue
        button.clipsToBounds = true
        return button
    }()
    
    private let taggedButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "tag"), for: .normal)
        button.tintColor =  .lightGray
        button.clipsToBounds = true
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        
        gridButton.addTarget(self, action: #selector(methoddidtappedGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didtappedTaggedButton), for: .touchUpInside)
        
    }
    @objc private func methoddidtappedGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didtappedGridButton()
    }
    @objc private func didtappedTaggedButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didtappedTaggedButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding*2)
        let gridButtonX = (width/2 - size)/2
        
        gridButton.frame = CGRect(x: gridButtonX, y: Constants.padding, width: size, height: size)
        
        taggedButton.frame = CGRect(x: gridButtonX + (width/2), y: Constants.padding, width: size, height: size)
        
    }
}
