//
//  GradientView.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// Wraps CAGradientLayer. Supports dynamic colors.
class GradientView: UIView {

	var startColor: UIColor = .clear {didSet {update()}}
	var endColor: UIColor = .black {didSet {update()}}
	var startY: CGFloat = 0 {didSet {update()}}
	var endY: CGFloat = 1 {didSet {update()}}

	override class var layerClass: AnyClass {CAGradientLayer.self}
	var gradientLayer: CAGradientLayer {return layer as! CAGradientLayer}

	convenience init(startColor: UIColor = .clear, endColor: UIColor = .black, startY: CGFloat = 0, endY: CGFloat = 1) {
		self.init()
		self.startColor = startColor
		self.endColor = endColor
		self.startY = startY
		self.endY = endY
		update()
	}

	// MARK: - Private
	private func update() {
		let traitCollection = self.traitCollection

		gradientLayer.colors = [
			startColor.resolvedColor(with: traitCollection).cgColor,
			endColor.resolvedColor(with: traitCollection).cgColor,
		]
		gradientLayer.startPoint.y = startY
		gradientLayer.endPoint.y = endY
	}

	// MARK: - UIView
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		update()
	}
}
