//
//  SettingViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit
import SafariServices

struct SettingCellMode{
    let title : String
    let handle : (()-> Void)
}

final class SettingViewController: UIViewController {
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    private var data = [[SettingCellMode]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configuareModels()
        
        // Do any additional setup after loadin g the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configuareModels(){
        data.append([
            SettingCellMode(title: "Edit Profile"){ [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellMode(title: "InviteFriend"){ [weak self] in
                self?.didTapInviteFriend()
            },
            SettingCellMode(title: "Save Original Posts"){ [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        data.append([
            SettingCellMode(title: "Terms of Service"){ [weak self] in
                self?.openUrl(type: .term)
            },
            SettingCellMode(title: "Privacy Profile"){ [weak self] in
                self?.openUrl(type: .privacy)
            },
            SettingCellMode(title: "Help / Feedback"){ [weak self] in
                self?.openUrl(type: .help)
            }
        ])
        data.append([
            SettingCellMode(title: "Log out"){ [weak self] in
                self?.didTapLogOut()
                
            }
        ])
    }
    private func didTapEditProfile(){
        let vc = ProfileEditViewController()
        vc.title = "Edit Profile"
        let navvc = UINavigationController(rootViewController: vc)
        navvc.modalPresentationStyle = .fullScreen
        present(navvc,animated: true)
    }
    private func didTapInviteFriend(){
        
    }
    private func didTapSaveOriginalPosts(){
        
    }
    enum SettingURLType{
        case term,privacy,help
        
    }
    public func openUrl(type : SettingURLType)
    {
        var urlString :String
        switch type{
        case .term : urlString = "https://help.instagram.com/581066165581870"
        case .privacy : urlString = "https://privacycenter.instagram.com/policy"
        case .help : urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string : urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
        
    }
    private func didTapLogOut(){
        
        let actionSheet = UIAlertController(title: "Log out", message: "Are you sure", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log out ", style: .destructive,
                                            handler: { _ in
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // handle to open login form
                        let loginVc = LoginViewController()
                        loginVc.modalPresentationStyle = .fullScreen
                        self.present(loginVc, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        // log error
                        fatalError("Could not log out user")
                    }
                }
               
                
            })
            
            
                                                }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
       present(actionSheet,animated: true)
    }
}
extension SettingViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handle( )
    }
    
    
}
