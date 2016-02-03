//
//  MovieListViewController.swift
//  YouPlay-Mac
//
//  Created by 吴建国 on 16/2/3.
//  Copyright © 2016年 wujianguo. All rights reserved.
//

import Cocoa


class MovieListViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        requestMoreData()

    }
    
    let cellIdentifier = "MovieCollectionViewItem"
    
    var items = [YouPlayItem]()
    var itemIndex = 1
    
    var channel = YouPlaychannel.Teleplay
    
    func channelChangedTo(channel: YouPlaychannel) {
        self.channel = channel
        items.removeAll()
        itemIndex = 1
        collectionView.reloadData()
        requestMoreData()
    }
    
    func requestMoreData() {
        let c = channel
        queryItems(channel, page: itemIndex) { (items, succ) -> Void in
            guard succ && c == self.channel else { return }
            var indexPaths = [NSIndexPath]()
            for i in 0..<items.count {
                indexPaths.append(NSIndexPath(forItem: self.items.count + i, inSection: 0))
            }
            self.itemIndex += 1
            self.items.appendContentsOf(items)
            self.collectionView.insertItemsAtIndexPaths(Set(indexPaths))
            self.setBackground()
        }
    }
    
    func setBackground() {
        /*
        let originalImage = NSImage(named: "myImageName")
        let inputImage = CIImage(data: (originalImage?.TIFFRepresentation)!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter!.setDefaults()
        filter!.setValue(inputImage, forKey: kCIInputImageKey)
        let outputImage = filter!.valueForKey(kCIOutputImageKey) as! CIImage
        let outputImageRect = NSRectFromCGRect(outputImage.extent)
        let blurredImage = NSImage(size: outputImageRect.size)
        blurredImage.lockFocus()
        outputImage.drawAtPoint(NSZeroPoint, fromRect: outputImageRect, operation: .CompositeCopy, fraction: 1.0)
        blurredImage.unlockFocus()
        */
        
//        print("\(collectionView.backgroundView)")
    }
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItemWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieCollectionViewItem
        item.movie = items[indexPath.item]
        if indexPath.item == items.count - 1 {
            requestMoreData()
        }
        return item
    }
    
    
    struct CellRatio {
        static let x = CGFloat(250)
        static let y = CGFloat(125)
    }
    
    let mininumInteritemSpacing = CGFloat(8)
    
    var collectionViewEdgeInset = NSEdgeInsetsMake(8, 8, 8, 8)
    
    func calculateCellNum(size: CGSize) -> Int {
        let width = size.width - collectionViewEdgeInset.left - collectionViewEdgeInset.right + mininumInteritemSpacing
        let num = width / (CellRatio.x + mininumInteritemSpacing)
        let actXNum = num - CGFloat(Int(num)) >= 0.7 ? Int(num) + 1 : Int(num)
        return actXNum > 0 ? actXNum : 1
    }
    
    var collectionCellWidth: CGFloat {
        let bounds = collectionView!.bounds
        let width = bounds.width - collectionViewEdgeInset.left - collectionViewEdgeInset.right + mininumInteritemSpacing
        let n = calculateCellNum(bounds.size)
        return width/CGFloat(n) - mininumInteritemSpacing
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = collectionCellWidth
        return CGSizeMake(width, width*CellRatio.y/CellRatio.x)
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return mininumInteritemSpacing
    }
    
    func collectionView(collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAtIndex section: Int) -> NSEdgeInsets {
        return collectionViewEdgeInset
    }

}
