//
//  OnboardingExplanationViewController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class OnboardingExplanationBluetoothViewController: UIViewController {
	private var customView: OnboardingIntroView! {return view as? OnboardingIntroView}

	// MARK: - Input
	@objc private func nextTapped(_ sender: Any) {
		navigationController?.pushViewController(OnboardingExplanationNotificationViewController(), animated: true)
	}
	
	// MARK: - UIViewController
	override func loadView() {
		let customView = OnboardingIntroView()
		customView.imageView.image = UIImage(named: "OnboardingExplanationBluetoothHeader")
		customView.markdownTitle = NSLocalizedString("onboarding_explanation_bluetooth_markdown_title", comment: "")
		customView.textLabel.text = NSLocalizedString("onboarding_explanation_bluetooth_text", comment: "")
		customView.button.title = NSLocalizedString("button_next", comment: "")
		customView.button.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
		view = customView
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		customView.textScrollView.flashScrollIndicators()
	}
}
