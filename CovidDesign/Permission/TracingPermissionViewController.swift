//
//  TracingPermissionViewController.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class TracingPermissionViewController: UIViewController {
	private var customView: View! {return view as? View}

	// MARK: - Input
	@objc private func laterTapped(_ sender: Any) {
		navigationController?.pushViewController(TracingPermissionViewController(), animated: true)
	}

	@objc private func givePermissionTapped(_ sender: Any) {
		navigationController?.pushViewController(BluetoothPermissionViewController(), animated: true)
	}

	// MARK: - UIViewController
	override func loadView() {
		let customView = View()
		customView.laterButton.addTarget(self, action: #selector(laterTapped(_:)), for: .touchUpInside)
		customView.givePermissionButton.addTarget(self, action: #selector(givePermissionTapped(_:)), for: .touchUpInside)
		view = customView
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		customView.textScrollView.flashScrollIndicators()
	}
}

// MARK: - View
extension TracingPermissionViewController {
	class View: UIView {
		let stackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)

		// title + items
		let titleLabel = UILabel(customFontDescriptor: .title)
		let itemsList = UIStackView(axis: .vertical, spacing: .defaultSpacing * 1.5)

		// text
		let textAlignmentStackView = UIStackView(axis: .horizontal, alignment: .center)
		let textScrollView = OverflowScrollView()
		let textStackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)

		// buttons
		let laterButton = RoundRectButton(style: .foregroundTinted)
		let givePermissionButton = RoundRectButton(style: .backgroundTinted)
		let buttonsStackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)

		// MARK: - Private
		static func item(simpleMarkdownText: String) -> UIStackView {
			let imageView = UIImageView(image: UIImage(named: "PermissionItemShield"))
			imageView.contentMode = .center
			imageView.accessibilityIgnoresInvertColors = true
			imageView.setContentHuggingPriority(.required, for: .horizontal)

			let label = UILabel(customFontDescriptor: .body)
			label.attributedText = NSAttributedString(simpleMarkdownFrom: simpleMarkdownText, customFontDescriptor: .body)

			return UIStackView(filledWith: [imageView, label], axis: .horizontal, alignment: .firstBaseline, spacing: .defaultSpacing)
		}

		private func setup() {
			backgroundColor = .systemBackground

			titleLabel.attributedText = NSAttributedString(simpleMarkdownFrom: NSLocalizedString("tracing_permissions_markdown_title", comment: ""), customFontDescriptor: .title)
			itemsList.addArrangedSubviews(
				Self.item(simpleMarkdownText: NSLocalizedString("tracing_permission_item_1", comment: "")),
				Self.item(simpleMarkdownText: NSLocalizedString("tracing_permission_item_2", comment: "")),
				Self.item(simpleMarkdownText: NSLocalizedString("tracing_permission_item_3", comment: ""))
			)
			textStackView.addArrangedSubviews(titleLabel, itemsList)
			textScrollView.addOverflowSubview(textStackView)
			textAlignmentStackView.addArrangedSubview(textScrollView)

			// buttons
			laterButton.title = NSLocalizedString("button_maybe_later", comment: "")
			givePermissionButton.title = NSLocalizedString("button_give_permission", comment: "")
			buttonsStackView.addArrangedSubviews(laterButton, givePermissionButton)

			// stack view holding image + text + button.
			// We don't use the readableLayoutGuide horizontall here, because we want our textScrollView to go edge-to-edge.
			// That way, space outside of the readable guide is also scrollable and the scroll indicator shows at
			// the screen's edge.
			stackView.preservesSuperviewLayoutMargins = true
			stackView.translatesAutoresizingMaskIntoConstraints = false
			addSubview(stackView)
			NSLayoutConstraint.activate([
				stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
				stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
				stackView.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
				stackView.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor, constant: .defaultSpacing * -1),
			])
			stackView.addArrangedSubviews(textAlignmentStackView, .readableContentGuideWrapper(for: buttonsStackView))
		}

		// MARK: - UIView
		override init(frame: CGRect) {
			super.init(frame: frame)
			setup()
		}

		required init?(coder: NSCoder) {
			super.init(coder: coder)
			setup()
		}
	}
}
