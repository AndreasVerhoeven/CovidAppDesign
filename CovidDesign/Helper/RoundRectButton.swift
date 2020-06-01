//
//  RoundRectButton.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// Button Control with a RoundRect style ("platter").
// Supports dynamic type and does highlighting like the stock
// UIButton (no animation on first touch down).
class RoundRectButton: UIControl {

	var minimalHeight = CGFloat(50)

	enum Style {
		case backgroundTinted
		case foregroundTinted
	}

	private let wrapperView = UIView()
	private let backgroundView = UIView()
	private let contentStackView = UIStackView()
	private let alignmentStackView = UIStackView()
	private var toggleAnimateNextAfterNextHighlightChange = false
	private var animateNextHighlightChange = false

	let label = UILabel()
	let imageView = UIImageView()

	var buttonBackgroundColor: UIColor? {
		get {return backgroundView.backgroundColor}
		set {backgroundView.backgroundColor = newValue}
	}

	var title: String? {
		get {attributedTitle?.string}
		set {
			label.text = newValue
			updateVisibility()
		}
	}

	var attributedTitle: NSAttributedString? {
		get {label.attributedText}
		set {
			label.attributedText = newValue
			updateVisibility()
		}
	}

	var image: UIImage? {
		didSet {
			imageView.image = image
			updateVisibility()
		}
	}

	var style = Style.backgroundTinted {
		didSet {
			updateStyle()
		}
	}

	convenience init(style: Style, frame: CGRect = .zero) {
		self.init(frame: frame)
		self.style = style
		updateStyle()
	}

	// MARK: - Private
	private func setup() {

		wrapperView.isUserInteractionEnabled = false
		wrapperView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(wrapperView)
		NSLayoutConstraint.activate([
			wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor),
			wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor),
			wrapperView.topAnchor.constraint(equalTo: topAnchor),
			wrapperView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])

		backgroundView.layer.cornerRadius = 12
		backgroundView.layer.cornerCurve = .continuous
		backgroundView.clipsToBounds = true
		backgroundView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.addSubview(backgroundView)
		NSLayoutConstraint.activate([
			backgroundView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
			backgroundView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
		])

		label.numberOfLines = 1
		label.adjustsFontForContentSizeCategory = true
		label.font = .customFont(.button)
		label.lineBreakMode = .byTruncatingTail

		imageView.contentMode = .scaleAspectFit
		imageView.tintAdjustmentMode = .normal
		imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true

		contentStackView.axis = .horizontal
		contentStackView.alignment = .center
		contentStackView.distribution = .fill
		contentStackView.spacing = UIStackView.spacingUseSystem

		contentStackView.addArrangedSubview(label)
		contentStackView.addArrangedSubview(imageView)

		alignmentStackView.axis = .vertical
		alignmentStackView.alignment = .center
		alignmentStackView.distribution = .fill
		alignmentStackView.isLayoutMarginsRelativeArrangement = true
		alignmentStackView.addArrangedSubview(contentStackView)

		alignmentStackView.translatesAutoresizingMaskIntoConstraints = false
		wrapperView.addSubview(alignmentStackView)
		alignmentStackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		label.setContentCompressionResistancePriority(.required, for: .vertical)
		NSLayoutConstraint.activate([
			alignmentStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
			alignmentStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
			alignmentStackView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
			alignmentStackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
			alignmentStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: minimalHeight),
		])

		wrapperView.isAccessibilityElement = false
		isAccessibilityElement = true
		accessibilityTraits.insert(.button)

		updateStyle()
		updateSymbolConfiguration()
		updateContentPadding()
		updateVisibility()
	}

	private func updateVisibility() {
		label.isHidden = (attributedTitle == nil || attributedTitle?.length == 0)
		imageView.isHidden = (image == nil)
	}

	private func updateStyle() {
		switch style {
			case .backgroundTinted:
				label.textColor = .white
				imageView.tintColor = .white
				backgroundView.backgroundColor = tintColor

			case .foregroundTinted:
				label.textColor = tintColor
				imageView.tintColor = tintColor
				backgroundView.backgroundColor = .secondarySystemBackground
		}
	}

	private func updateBackgroundAlpha() {
		if isEnabled == false {
			wrapperView.alpha = 0.25
		} else {
			wrapperView.alpha = (isHighlighted == true ? 0.5 : 1)
		}
	}

	private func updateSymbolConfiguration() {
		imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: label.font)
	}

	private func updateContentPadding() {
		let metrics = CustomFontDescriptor.button.fontMetrics()
		let horizontalPadding = metrics.scaledValue(for: 2)
		let cornerRadius = backgroundView.layer.cornerRadius
		alignmentStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: horizontalPadding, leading: cornerRadius, bottom: horizontalPadding, trailing: cornerRadius)
	}

	// MARK: - UIControl

	override var isEnabled: Bool {
		didSet {
			updateBackgroundAlpha()
		}
	}

	override var isHighlighted: Bool {
		didSet {
			guard isHighlighted != oldValue else {return}
			if animateNextHighlightChange == true {
				UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
					self.updateBackgroundAlpha()
				})
			} else {
				self.updateBackgroundAlpha()
			}

			if toggleAnimateNextAfterNextHighlightChange == true {
				animateNextHighlightChange.toggle()
				toggleAnimateNextAfterNextHighlightChange = false
			}
		}
	}

	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		toggleAnimateNextAfterNextHighlightChange = true
		return super.beginTracking(touch, with: event)
	}

	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		if isHighlighted == true {
			toggleAnimateNextAfterNextHighlightChange = true
		} else {
			animateNextHighlightChange = false
		}
		super.endTracking(touch, with: event)
	}

	// MARK: - UIView
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		updateSymbolConfiguration()
		updateContentPadding()
	}

	override func tintColorDidChange() {
		super.tintColorDidChange()
		updateStyle()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	// MARK: - NSObject
	override var accessibilityLabel: String? {
		get { return super.accessibilityLabel ?? title }
		set {super.accessibilityLabel = newValue }
	}
}
