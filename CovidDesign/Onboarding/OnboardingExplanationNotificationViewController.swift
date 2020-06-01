//
//  OnboardingExplanationNotificationViewController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class OnboardingExplanationNotificationViewController: UIViewController {
	private var customView: OnboardingIntroView! {return view as? OnboardingIntroView}

	// MARK: - Input
	@objc private func nextTapped(_ sender: Any) {
		navigationController?.pushViewController(TracingPermissionViewController(), animated: true)
	}

	// MARK: - UIViewController
	override func loadView() {
		let customView = OnboardingIntroView()
		customView.imageView.image = UIImage(named: "OnboardingExplanationNotificationHeader")
		customView.markdownTitle = NSLocalizedString("onboarding_explanation_notification_markdown_title", comment: "")
		customView.textLabel.text = NSLocalizedString("onboarding_explanation_notification_text", comment: "")
		customView.button.title = NSLocalizedString("button_next", comment: "")
		customView.button.addTarget(self, action: #selector(nextTapped(_:)), for: .touchUpInside)
		view = customView
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		customView.textScrollView.flashScrollIndicators()
	}
}
