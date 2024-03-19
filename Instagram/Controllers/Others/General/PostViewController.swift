//
//  PostDetailtViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit
enum PostRenderType{
    case header(provider : User)
    case primaryContent(provider : UserPost)
    case action(provider : String)
    case comments(provider :[PostComment])
}
struct PostRenderModel{
    let renderType : PostRenderType
}

class PostViewController: UIViewController {
    private let model : UserPost?
    
    private var data = [PostRenderModel]()
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.indentifier)
        table.register(HeaderFeedTableViewCell.self, forCellReuseIdentifier: HeaderFeedTableViewCell.indentifier)
        table.register(ActionFeedTableViewCell.self, forCellReuseIdentifier: ActionFeedTableViewCell.indentifier)
        table.register(GeneralFeedTableViewCell.self, forCellReuseIdentifier: GeneralFeedTableViewCell.indentifier)
        return table
    }()
    
    init(model : UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configuareModel()
    }
    private func configuareModel(){
        guard let userPostModel = self.model else {
            return
        }
        // header
        data.append(PostRenderModel(renderType: .header(provider: userPostModel.owner)))
        
        // post
        data.append(PostRenderModel(renderType: .primaryContent(provider: userPostModel)))
        // action
        data.append(PostRenderModel(renderType: .action(provider: "")))
        // comment
        var comments = [PostComment]()
        for x in 0...5{
            comments.append(PostComment(identifier: "123\(x)",
                                        username: "Nghia",
                                        text: "Beautifull",
                                        createDate: Date(),
                                        likes: []))
        }
        data.append(PostRenderModel(renderType: .comments(provider: comments)))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
extension PostViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch data[section].renderType{
        case .action(_) : return 1
        case .comments(let comments) : return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_) : return 1
        case .header(_) : return 1
        
        }
        
            
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.section]
        switch model.renderType{
        case .action(let actions) :
            let cell = tableView.dequeueReusableCell(withIdentifier: ActionFeedTableViewCell.indentifier,
                                                     for: indexPath) as! ActionFeedTableViewCell
            return cell
        case .comments(let comments) :
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralFeedTableViewCell.indentifier,
                                                     for: indexPath) as! GeneralFeedTableViewCell
            return cell
        case .primaryContent(let contents) :
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.indentifier,
                                                     for: indexPath) as! FeedTableViewCell
            return cell
        case .header(let header) :
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderFeedTableViewCell.indentifier,
                                                     for: indexPath) as! HeaderFeedTableViewCell
            return cell
        
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = data[indexPath.section]
        switch model.renderType{
        case .action(_) : return 60
        case .comments(_) : return 50
        case .primaryContent(_) : return tableView.width
        case .header(_) : return 70
        }
    }
    
}
