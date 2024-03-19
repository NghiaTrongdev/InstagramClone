//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import UIKit

class ExploreViewController: UIViewController {
    private let searchBar : UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.backgroundColor = .secondarySystemBackground
        return searchbar
    }()
    private var collectionView : UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        // Do any additional setup after loading the view.
    }


}
extension ExploreViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

