//
//  NoNotificationView.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 15/03/2024.
//

import UIKit

class NoNotificationView: UIView {

    public static let identifier = "NoNotificationView"
    
    private let notificationLabel : UILabel = {
        let label = UILabel()
        label.text = "No Notification yet"
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .secondaryLabel
        image.image = UIImage(systemName: "bell")
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(notificationLabel)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width - 50) / 2 , y: 0, width: 50, height: 50).integral
        notificationLabel.frame = CGRect(x: 0, y:imageView.bottom , width: width, height:height - 50 ).integral
    }
}
