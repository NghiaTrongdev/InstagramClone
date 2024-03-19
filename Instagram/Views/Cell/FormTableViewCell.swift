//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 11/03/2024.
//

import UIKit
protocol FormTableViewCellDelegate : AnyObject {
    func formTableViewCell(_ cell : FormTableViewCell, didUpdateField model : EditProfileFormModel)
}
class FormTableViewCell: UITableViewCell {
    static let identifier = "FormTableViewCell"
    
    public weak var delegate:FormTableViewCellDelegate?
    
    private var model : EditProfileFormModel?
    
    private let formLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let formField : UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(formLabel)
        contentView.addSubview(formField)
        clipsToBounds = true
        selectionStyle = .none
        formField.delegate = self
    }
    public func configuare(with model : EditProfileFormModel){
        self.model = model
        formLabel.text = model.label
        formField.placeholder = model.placeholder
        formField.text = model.value
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        formField.placeholder = nil
        formField.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        
        formField.frame = CGRect(x: formLabel.right+10, y: 0, width: contentView.width - formLabel.width - 10, height: contentView.height)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension FormTableViewCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
