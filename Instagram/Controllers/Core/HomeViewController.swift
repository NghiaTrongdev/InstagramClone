//
//  ViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//
import FirebaseAuth
import UIKit
struct HomeFeedViewModel {
    let header : PostRenderModel
    let feed : PostRenderModel
    let action :PostRenderModel
    let comment : PostRenderModel
}
class HomeViewController: UIViewController {
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.indentifier)
        table.register(HeaderFeedTableViewCell.self, forCellReuseIdentifier: HeaderFeedTableViewCell.indentifier)
        table.register(ActionFeedTableViewCell.self, forCellReuseIdentifier: ActionFeedTableViewCell.indentifier)
        table.register(GeneralFeedTableViewCell.self, forCellReuseIdentifier: GeneralFeedTableViewCell.indentifier)
        return table
    }()

    private var models = [HomeFeedViewModel]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createData()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
       
    }
    private func createData(){
        let user = User(username: "Nghia", bio: "", name: (first:"",last : ""),
                        profileImage: URL(string: "https//www.google.com")!, gender: .famale, birthDate: Date(), joinDate: Date(), counts: UserCount(flowing: 1, flowers: 1, posts: 1))
        let post = UserPost(identifier: "",
                            posttype: .photo,
                            thumnailImage: URL(string: "https//www.google.com")!,
                            postUrl: URL(string: "https//www.google.com")!,
                            caption: "", likeCount: [],
                            comments: [], taggedUser: [],owner: user)
        var comments = [PostComment]()
        for x in 0...5{
            comments.append(PostComment(identifier: "123\(x)",
                                        username: "Nghia",
                                        text: "Beautifull",
                                        createDate: Date(),
                                        likes: []))
        }
        
        for x in 0..<5 {
            let model = HomeFeedViewModel(header: PostRenderModel(renderType: .header(provider: user)),
                                          feed: PostRenderModel(renderType: .primaryContent(provider: post)),
                                          action: PostRenderModel(renderType: .action(provider: "")),
                                          comment: PostRenderModel(renderType: .comments(provider: comments)))
            models.append(model)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleAuth()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    private func handleAuth(){
        if Auth.auth().currentUser == nil {
            // Chuyen sang kenh Login
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: true)
        }
    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model : HomeFeedViewModel
        if ( x == 0){
            model = models[0]
        } else {
            let position = x % 4 == 0 ? x / 4: ((x - (x % 4)) / 4)
            model = models[position]
        }
        
        let subsection = x % 4
        if subsection == 0 {
            // header
            return 1
        } else if subsection == 1 {
            // post
            return 1
            
            
        } else if subsection == 2 {
            // action
            return 1
        } else if subsection == 3 {
            // comments
            let commentModel = model.comment
            switch commentModel.renderType {
            case.comments(let comments) : return comments.count > 2 ? 2 : comments.count
            case .action , .header , .primaryContent : return 0
            
            }
        }
        return 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model : HomeFeedViewModel
        if ( x == 0){
            model = models[0]
        } else {
            let position = x % 4 == 0 ? x / 4: ((x - (x % 4)) / 4)
            model = models[position]
        }
        
        let subsection = x % 4
        if subsection == 0 {
            // header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderFeedTableViewCell.indentifier,
                                                         for: indexPath) as! HeaderFeedTableViewCell
                return cell
            case .action , .comments, .primaryContent : return UITableViewCell()
            }
            
            
        } else if subsection == 1 {
            // post
            let postModel = model.feed
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.indentifier,
                                                         for: indexPath) as! FeedTableViewCell
                return cell
                
            case .action , .comments, .header : return UITableViewCell()
            }
            
            
        } else if subsection == 2 {
            // action
            let actionModel  = model.action
            switch actionModel.renderType {
            case .action(let action):
                let cell = tableView.dequeueReusableCell(withIdentifier: ActionFeedTableViewCell.indentifier,
                                                         for: indexPath) as! ActionFeedTableViewCell
                return cell
            case .header , .comments, .primaryContent : return UITableViewCell()
            }
            
        } else if  subsection == 3 {
            // comments
            let commentModel = model.comment
            switch commentModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: GeneralFeedTableViewCell.indentifier,
                                                         for: indexPath) as! GeneralFeedTableViewCell
                return cell
            case .action , .header, .primaryContent : return UITableViewCell()
            }
            
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section  = indexPath.section % 4
        if section == 0 {
            return 70
        } else if section == 1 {
            return tableView.width
        } else if section == 2 {
            return 60
        } else if section == 3 {
            return 50
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var subsection = section % 4
        return subsection == 3 ? 70 : 0
        
    }
}
    


