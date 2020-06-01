//
//  ThemedNavigationController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// Small helper to show transparent navigation bars.
class ThemedNavigationController: UINavigationController {

	// MARK: - UIViewController
	override func viewDidLoad() {
		super.viewDidLoad()

		navigationBar.standardAppearance.configureWithTransparentBackground()
		navigationBar.compactAppearance = UINavigationBarAppearance()
		navigationBar.compactAppearance?.configureWithTransparentBackground()
	}
}

