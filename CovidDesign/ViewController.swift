//
//  ViewController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@objc private func buttonTapped(_ sender: Any) {
		let navigationController = UINavigationController(rootViewController: OnboardingIntroViewController())
		navigationController.navigationBar.standardAppearance.configureWithTransparentBackground()
		navigationController.navigationBar.compactAppearance = UINavigationBarAppearance()
		navigationController.navigationBar.compactAppearance?.configureWithTransparentBackground()
		present(navigationController, animated: true)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let button = RoundRectButton(frame: CGRect(x: 20, y: 100, width: 200, height: 44))
		button.style = .backgroundTinted
		button.attributedTitle = NSAttributedString(simpleMarkdownFrom: "_/xx/xx_ button", customFontDescriptor: .button)
		button.image = UIImage(systemName: "chevron.right")

		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		NSLayoutConstraint.activate([
			button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
		])

		button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
	}
}

