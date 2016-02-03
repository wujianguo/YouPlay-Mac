//

import Foundation
import AppKit
import SnapKit

class NSLabel: NSTextField {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: NSRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        super.bezeled = false;
        super.drawsBackground = false;
        super.editable = false;
        super.selectable = false;
    }
    
    var text: String? {
        get {
            return stringValue
        }
        set {
            if newValue != nil {
                stringValue = newValue!
            }
        }
    }
}

class MovieCollectionViewItem: NSCollectionViewItem {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    var thumbImage = NSImageView()
    var nameLabel = NSLabel()
    var statusLabel = NSLabel()
    var ratingLabel = NSLabel()
    var actors = NSLabel()
    
    func setup() {
        
        nameLabel.textColor = NSColor.whiteColor()
        statusLabel.textColor = NSColor.whiteColor()
        ratingLabel.textColor = NSColor.whiteColor()
        actors.textColor = NSColor.whiteColor()
        
        nameLabel.font = NSFont.systemFontOfSize(15)
        statusLabel.font = NSFont.systemFontOfSize(12)
        ratingLabel.font = NSFont.systemFontOfSize(12)
        actors.font = NSFont.systemFontOfSize(12)

        nameLabel.maximumNumberOfLines = 0
        
        let contentView = view
        
        contentView.addSubview(thumbImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(actors)
        
        thumbImage.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(8)
            make.bottom.equalTo(-8)
            make.width.equalTo(thumbImage.snp_height).multipliedBy(1.0/1.5)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(thumbImage.snp_right).offset(18)
            make.top.equalTo(thumbImage).offset(8)
            make.right.equalTo(contentView).offset(-8)
        }
        
        ratingLabel.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(nameLabel)
            make.bottom.equalTo(thumbImage.snp_bottom).offset(-8)
        }
        
        actors.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(nameLabel)
            make.bottom.lessThanOrEqualTo(ratingLabel.snp_top).offset(-12)
        }
        
        statusLabel.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(nameLabel)
            make.bottom.lessThanOrEqualTo(actors.snp_top).offset(-12)
        }

    }
    
    func updateUI() {
        nameLabel.text = movie.title
        statusLabel.text = movie.status
        ratingLabel.text = "评分: \(movie.rating)"
        
        var text = ""
        for a in movie.actors {
            text += "\(a) "
        }
        actors.text = text
        thumbImage.setImageWithUrlString(movie.thumb)
    }
	
	// MARK: properties
	
    var movie: YouPlayItem! {
        didSet {
            updateUI()
        }
    }
	
    override var selected: Bool {
		didSet {
			(self.view as! MovieCollectionViewItemView).selected = selected
		}
	}
    
	override var highlightState: NSCollectionViewItemHighlightState {
		didSet {
			(self.view as! MovieCollectionViewItemView).highlightState = highlightState
		}
	}

	// MARK: outlets
	

    
	// MARK: NSResponder

	override func mouseDown(theEvent: NSEvent) {
		if theEvent.clickCount == 2 {

        } else {
			super.mouseDown(theEvent)
		}
		
	}

}

