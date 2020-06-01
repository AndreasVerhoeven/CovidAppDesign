//
//  BluetoothPermissionViewController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class BluetoothPermissionViewController: UIViewController {
	private var customView: OnboardingIntroView! {return view as? OnboardingIntroView}

	// MARK: - Input
	@objc private func laterTapped(_ sender: Any) {
		self.view.window?.switchRootViewController(StatusNavigationController(), animated: true)
	}

	@objc private func enableBluetoothTapped(_ sender: Any) {
		self.view.window?.switchRootViewController(StatusNavigationController(), animated: true)
	}

	// MARK: - UIViewController
	override func loadView() {
		let customView = OnboardingIntroView()

		customView.imageView.image = UIImage(named: "BluetoothPermissionHeader")
		customView.imageView.accessibilityIgnoresInvertColors = true
		customView.markdownTitle = NSLocalizedString("bluetooth_permission_markdown_title", comment: "")
		customView.textLabel.text = NSLocalizedString("bluetooth_permission_text", comment: "")
		customView.button.title = NSLocalizedString("bluetooth_enable_button", comment: "")
		customView.additionalButton.title = NSLocalizedString("button_maybe_later", comment: "")

		customView.additionalButton.isHidden = false
		customView.additionalButton.addTarget(self, action: #selector(laterTapped(_:)), for: .touchUpInside)
		customView.button.addTarget(self, action: #selector(enableBluetoothTapped(_:)), for: .touchUpInside)
		view = customView
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		customView.textScrollView.flashScrollIndicators()
	}
}
