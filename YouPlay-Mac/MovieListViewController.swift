//
//  MovieListViewController.swift
//  YouPlay-Mac
//
//  Created by 吴建国 on 16/2/3.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa


class MovieListViewController: NSViewController, NSCollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
    
    let cellIdentifier = "LabelCollectionViewItem"
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItemWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        return item
    }
}
