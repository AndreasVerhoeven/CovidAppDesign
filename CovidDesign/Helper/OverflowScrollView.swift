//
//  OverflowScrollView.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// this scrollview has an intrinsic content size, so it participates in (StackView) AutoLayout
class OverflowScrollView: UIScrollView {

	func addOverflowSubview(_ view: UIView) {
		alwaysBounceVertical = false
		alwaysBounceHorizontal = false
		contentInsetAdjustmentBehavior = .never
		preservesSuperviewLayoutMargins = true
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
			view.topAnchor.constraint(equalTo: topAnchor),
			view.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}

	override var contentSize: CGSize {
		didSet {
			invalidateIntrinsicContentSize()
		}
	}

	override var intrinsicContentSize: CGSize {
		let size = self.contentSize
		return size
	}
}

