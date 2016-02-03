//

import Foundation
import AppKit

class MovieCollectionViewItemView: NSView {

	// MARK: properties
	
	var selected: Bool = false {
		didSet {
			if selected != oldValue {
				needsDisplay = true
			}
		}
	}
	var highlightState: NSCollectionViewItemHighlightState = .None {
		didSet {
			if highlightState != oldValue {
				needsDisplay = true
			}
		}
	}
	
	// MARK: NSView

	override var wantsUpdateLayer: Bool {
		return true
	}

	override func updateLayer() {
		if selected {
			layer!.backgroundColor = NSColor.darkGrayColor().CGColor
		} else {
			self.layer?.cornerRadius = 4
			layer!.backgroundColor = NSColor.lightGrayColor().CGColor
		}
		
	}

	// MARK: init

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		wantsLayer = true
		layer?.masksToBounds = true
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		wantsLayer = true
		layer?.masksToBounds = true
	}
}