//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit


final class NotificationsViewController: UIViewController {
    private let tableView : UITableView = {
        let table = UITableView()
        table.isHidden = false
        table.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        table.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return table
    }()
    
    private var models = [UserNotification]()

    private let sprinner : UIActivityIndicatorView = {
        let sprinner = UIActivityIndicatorView()
        sprinner.hidesWhenStopped = true
        sprinner.color = .label
        return sprinner
    }()
    private lazy var noNotificationView = NoNotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Notification"
        view.addSubview(sprinner)
//        sprinner.startAnimating()
        view.addSubview(tableView)
//        view.addSubview(noNotificationView)
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        sprinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        sprinner.center = view.center
        
    }
    private func fetchData(){
        for i in 0...10{
            let user = User(username: "Nghia", bio: "", name: (first:"",last : ""),
                            profileImage: URL(string: "https//www.google.com")!, gender: .famale, birthDate: Date(), joinDate: Date(), counts: UserCount(flowing: 1, flowers: 1, posts: 1))
            let post = UserPost(identifier: "",
                                posttype: .photo,
                                thumnailImage: URL(string: "https//www.google.com")!,
                                postUrl: URL(string: "https//www.google.com")!,
                                caption: "", likeCount: [],
                                comments: [], taggedUser: [],owner: user)
            let model = UserNotification(type: i % 2 == 0 ?.like(post: post) : .follow(state: .following),
                                         text: "Nghia ne",
                                         user: user)
            models.append(model)
        }
    }
    private func addNoNotification(){
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.width / 4)
        noNotificationView.center = view.center
    }

}
extension NotificationsViewController : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier,
                                                     for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configuare(with: model)
            cell.delegate = self
            return cell
        case .follow :
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NotificationFollowEventTableViewCell.identifier,
                                                     for: indexPath) as! NotificationFollowEventTableViewCell
//            cell.configuare(with: model)
            cell.delegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension NotificationsViewController : NotificationLikeEventTableViewCellDelegate{
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        
        case.like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.posttype.rawValue
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true )
        case.follow(_):
            fatalError("Issues")
            break
            
        }
    }
}
extension NotificationsViewController : NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnfollowButton(with model: UserNotification) {
        print("Tapped unfollow button")
    }

}
