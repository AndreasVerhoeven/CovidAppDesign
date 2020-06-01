//
//  CircleView.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// Exactly what it says on the tin.
class CircleView: UIView {

	// MARK: - Private
	private func setup() {
		widthAnchor.constraint(equalTo: heightAnchor).isActive = true
	}

	// MARK: - UIView
	override func layoutSubviews() {
		layer.cornerRadius = bounds.size.width * 0.5
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}
}
