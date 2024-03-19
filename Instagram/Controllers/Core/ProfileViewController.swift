//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit

 
final class ProfileViewController: UIViewController {
    
    private var collectionView : UICollectionView?
    
    private var userPosts = [UserPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        view.backgroundColor = .systemBackground
        configuareSetting()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        
        let size = (view.width - 4) / 3
        layout.itemSize = CGSize(width: size, height: size)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        
        
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        collectionView?.register(ProfileInforHeaderCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInforHeaderCollectionReusableView.identifier)
        
        collectionView?.register(ProfileTabCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabCollectionReusableView.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    private func configuareSetting(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didtapSettingButton))
    }
    @objc func didtapSettingButton(){
        let vc = SettingViewController()
        vc.title = "Setting"
        navigationController?.pushViewController(vc, animated: true)
    }
    


}
extension ProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return userPosts.count
        if section == 0 {
            return 0
        }
        return 30
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configuare(with: "test")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = userPosts[indexPath.row]
        let vc = PostPublishViewController(model: model)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1{
            let tabControllHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ProfileTabCollectionReusableView.identifier,
                for: indexPath) as! ProfileTabCollectionReusableView
            tabControllHeader.delegate = self
            return tabControllHeader
        }
        let profileheader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ProfileInforHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInforHeaderCollectionReusableView
        profileheader.delegate = self
        return profileheader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.width, height: view.height/3)
        }
        
        return CGSize(width: view.width, height: 50)
    }
    
    
}

extension ProfileViewController : ProfileInforHeaderCollectionReusableViewDelegate {
    func profileheaderDidTapPostButton(_ header: ProfileInforHeaderCollectionReusableView) {
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .bottom, animated: true)
    }
    
    func profileheaderDidTapFollowingButton(_ header: ProfileInforHeaderCollectionReusableView) {
        var model = [UserRelations]()
        for x in 0..<10 {
            model.append(UserRelations(name: "Nghia", username: "ne", type: x % 2 == 0 ? .following : .not_follow))
        }
        let vc = ListViewController(data:model)
        vc.title = "Following"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileheaderDidTapFollowersButton(_ header: ProfileInforHeaderCollectionReusableView) {
        var model = [UserRelations]()
        for x in 0..<10 {
            model.append(UserRelations(name: "Nghia", username: "ne", type:  x % 2 == 0 ? .following : .not_follow))
        }
        let vc = ListViewController(data:model)
        vc.title = "Follower"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func profileheaderDidTapEditButton(_ header: ProfileInforHeaderCollectionReusableView) {
        let vc = ProfileEditViewController()
        vc.title = "Edit Profile"
        navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated:true)
    }
}
extension ProfileViewController : ProfileTabCollectionReusableViewDelegate {
    func didtappedGridButton() {
        //
    }
    
    func didtappedTaggedButton() {
        //
    }
    
    
}
