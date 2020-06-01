//
//  UITableView+Helper.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension UITableView {
	func relayoutTableHeaderView(animated: Bool = false) {
		guard let headerView = tableHeaderView else {return}
		updateTableViewHeader(headerView, animated: animated)
	}

	func updateTableViewHeader( _ headerView: UIView, animated: Bool = false) {
		// UITableView doesn't really work nicely with autosizing header views:
		// the solution is to autosize the header ourselves.
		
		let needsWidthConstraint = (headerView != tableHeaderView)

		// WORKAROUND (iOS 13, *) we have to set the tableHeaderView height manually first, otherwise the table cells
		// are at the wrong position and cannot be interacted with :-(
		let fittingSize = CGSize(width: bounds.width - (safeAreaInsets.left + safeAreaInsets.right), height: 0)
		let size = headerView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
		headerView.frame = CGRect(origin: .zero, size: size)
		tableHeaderView = headerView

		if needsWidthConstraint {
			headerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
		}
	}
}
