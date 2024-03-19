//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 11/03/2024.
//
import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    private var imageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        accessibilityHint = "Double-tap to open"
        accessibilityLabel = "User post iamge"
    }
    public func configuare(with model : UserPost ){
        let url = model.thumnailImage
        imageView.sd_setImage(with: url)
    }
    public func configuare(with imageName : String){
        imageView.image = UIImage(named: imageName)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
