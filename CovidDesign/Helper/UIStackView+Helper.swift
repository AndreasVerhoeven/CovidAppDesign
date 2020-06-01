//
//  UIStackView+Helper.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension UIStackView {
	convenience init(filledWith arrangSubviews: [UIView] = [],
					 axis: NSLayoutConstraint.Axis = .vertical,
					 alignment: UIStackView.Alignment = .fill,
					 distribution: UIStackView.Distribution = .fill,
					 spacing: CGFloat = 0,
					 insets: NSDirectionalEdgeInsets? = nil) {
		self.init(arrangedSubviews: arrangSubviews)
		self.axis = axis
		self.alignment = alignment
		self.distribution = distribution
		self.preservesSuperviewLayoutMargins = true
		self.spacing = spacing
		if let insets = insets {
			self.directionalLayoutMargins = insets
			self.isLayoutMarginsRelativeArrangement = true
		}
	}

	func removeAllArrangedSubviews() {
		arrangedSubviews.forEach {reallyRemoveArrangedSubview($0)}
	}

	func reallyRemoveArrangedSubview(_ view: UIView) {
		removeArrangedSubview(view)
		view.removeFromSuperview()
	}

	func addArrangedSubviews(_ subviews: [UIView]) {
		subviews.forEach {addArrangedSubview($0)}
	}

	func addArrangedSubviews(_ subviews: UIView...) {
		addArrangedSubviews(subviews)
	}
}
