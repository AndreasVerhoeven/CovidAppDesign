//
//  OnboardingIntroView.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class OnboardingIntroView: UIView {
	let stackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)
	let imageCenteringView = UIStackView(axis: .horizontal, alignment: .center)
	let imageView = UIImageView()

	var textScrollView = OverflowScrollView()
	let textStackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)

	let titleLabel = UILabel(customFontDescriptor: .title)
	let textLabel = UILabel(customFontDescriptor: .body)

	let buttonStackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)
	let button = RoundRectButton(style: .backgroundTinted)
	let additionalButton = RoundRectButton(style: .foregroundTinted) // hidden by default

	var markdownTitle: String? {
		didSet {
			titleLabel.attributedText = markdownTitle.map { NSAttributedString(simpleMarkdownFrom: $0, customFontDescriptor: .title) }
		}
	}

	// MARK: - Private
	private func setup() {
		backgroundColor = .systemBackground

		// image is wrapped in a view that center aligns it, so that it gets smaller if space is limited
		imageCenteringView.addArrangedSubview(imageView)
		imageCenteringView.setContentHuggingPriority(.defaultLow, for: .vertical)
		imageCenteringView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		imageView.contentMode = .scaleAspectFit

		// we wrap our button in a view so that we can follow the readableContentGuide
		buttonStackView.addArrangedSubviews(additionalButton, button)
		additionalButton.isHidden = true

		// our title + header are inside a vertical stack, which we embed in a scrollview:
		// even if there's not enough space, the user can always scroll to read it
		// (think of Jumbo Accessibility sizes)
		textStackView.addArrangedSubviews(titleLabel, textLabel)
		textStackView.addArrangedSubview(textLabel)
		textScrollView.addOverflowSubview(textStackView)

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
		stackView.addArrangedSubviews(imageCenteringView, textScrollView, .readableContentGuideWrapper(for: buttonStackView))
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
