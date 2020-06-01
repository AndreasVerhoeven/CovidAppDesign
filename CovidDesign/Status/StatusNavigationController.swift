//
//  StatusNavigationController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class StatusNavigationController: UINavigationController {

	init() {
		super.init(rootViewController: StatusViewController())
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.viewControllers = [StatusViewController()]
	}

	// MARK: - UIViewController
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return viewControllers.last?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
	}
}
