//
//  ProfileEditViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit
struct EditProfileFormModel{
    let label : String
    let placeholder : String
    var value : String?
    
}
class ProfileEditViewController: UIViewController {
    var models = [[EditProfileFormModel]]()
    
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.tableHeaderView = createHeaderView()
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self, action:#selector( didTapSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self, action:#selector( didTapCancelButton))
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func loadData(){
        //  name , username , website , bio
        let section1Labels = ["Name","Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for label in section1Labels{
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
            
        }
        models.append(section1)
        // email , phone , gender
        let section2Labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section1Labels{
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
            
        }
        models.append(section2)
    }
    
    private func createHeaderView() -> UIView{
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height / 1.5
        let profileImageButton = UIButton(frame: CGRect(x: (view.width - size)/2,
                                                        y: (header.height - size)/2,
                                                        width: size, height: size))
        header.addSubview(profileImageButton)
        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.cornerRadius = size/2
        profileImageButton.layer.borderWidth = 1
        profileImageButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        profileImageButton.tintColor = .label
        profileImageButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                              for: .normal)
        profileImageButton.addTarget(self,
                                     action: #selector(didTappedProfileButton),
                                     for: .touchUpInside)
        return header
    }
    @objc func didTappedProfileButton(){
            
    }
    
    @objc private func didTapSaveButton(){
        
    }
    @objc private func didTapCancelButton(){
        
    }
    @objc private func didTapChangeProfileImage(){
        let acctionSheet = UIAlertController(title: "Profile Picture",
                                             message: "Change Profile Image",
                                             preferredStyle: .actionSheet)
        acctionSheet.addAction(UIAlertAction(title: "Take Photo",
                                             style:.default ,
                                             handler: {_ in }))
        acctionSheet.addAction(UIAlertAction(title: "Choose from ",
                                             style:.default ,
                                             handler: {_ in }))
        acctionSheet.addAction(UIAlertAction(title: "Cancel",
                                             style:.cancel ,
                                             handler: nil))
        acctionSheet.popoverPresentationController?.sourceView = view
        acctionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(acctionSheet,animated: true)
    }
}
extension ProfileEditViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath.section số chỉ của section ,indexPath.row số chỉ của phần tử trong section đó
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configuare(with: model)
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private information"
    }
    
}
extension ProfileEditViewController : FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField model: EditProfileFormModel) {
        
    }
    
    
    
}
