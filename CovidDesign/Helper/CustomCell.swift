//
//  CustomCell.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 02/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

	// MARK: - UIVew
	override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
		let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
		return CGSize(width: size.width, height: max(size.height, 50))
	}
}
