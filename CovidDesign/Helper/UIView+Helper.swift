//
//  UIView+Helper.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension CGFloat {
	static let defaultSpacing = CGFloat(16)
}

extension UIView {
	static func readableContentGuideWrapper(for view: UIView) -> UIView {
		let wrapperView = UIView()
		wrapperView.addSubviewConstraintToReadableContentGuide(view)
		return wrapperView
	}

	// often used helper to add a subview and constrain it to the readable content guide directly
	func addSubviewConstraintToReadableContentGuide(_ view: UIView) {
		preservesSuperviewLayoutMargins = true
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
			view.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
			view.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor),
		])
	}

	// often used helper to add a subview and constrain it to the superview directly
	func addSubviewConstraintToSuperview(_ view: UIView, insets: NSDirectionalEdgeInsets = .zero) {
		preservesSuperviewLayoutMargins = true
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.leading),
			view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.trailing),
			view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
			view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
		])
	}
}
