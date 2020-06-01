//
//  CustomTableViewHeader.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class CustomTableViewHeader: UITableViewHeaderFooterView {
	let label = UILabel()

	// MARK: - Private
	private func setup() {
		label.numberOfLines = 0
		label.textColor = .label
		label.font = .customFont(.tableRow)
		contentView.addSubviewConstraintToReadableContentGuide(label)
	}


	// MARK: - UITableViewHeaderFooterView
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		setup()
	}

	// MARK: - UIView
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
}
