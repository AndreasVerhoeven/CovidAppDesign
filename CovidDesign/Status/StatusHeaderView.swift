//
//  StatusHeaderView.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// HeaderView for our tableview
class StatusHeaderView: UIView {

	// set this to true to make the background fixed. When "reduced motion" is enabled,
	// the background is always fixed
	var alwaysUsesFixedBackground = false

	// background: we adjust the backgroundView
	let backgroundView = GradientView()
	let backgroundClipView = UIView()
	let backgroundImageView = UIImageView(image: UIImage(named: "StatusBackground"))
	var backgroundViewTopConstraint: NSLayoutConstraint!

	let wrapperStackView = UIStackView(axis: .vertical, spacing: 0)
	let contentStackView = UIStackView(axis: .vertical, spacing: .defaultSpacing)
	let contentView = UIView()

	let labelsAlignmentStackView = UIStackView(axis: .horizontal, alignment: .center)
	let labelsStackView = UIStackView(axis: .vertical, spacing: UIStackView.spacingUseSystem)
	let statusTitleLabel = UILabel(customFontDescriptor: .title, textColor: .label, textAlignment: .center, numberOfLines: 0)
	let statusTextLabel = UILabel(customFontDescriptor: .body, textColor: .label, textAlignment: .center, numberOfLines: 0)

	let bottomDecorationView = UIView()

	// circles!
	let circleAlignmentView = UIStackView(axis: .vertical, alignment: .center)
	let outerCircle = CircleView()
	let middleCircle = CircleView()
	let innerCircle = CircleView()
	let checkmarkImageView = UIImageView(image: UIImage(systemName: "checkmark"))

	// used to make the headerview expands to the top of the device, not the safeArea
	var insetsToCompensateFor = UIEdgeInsets.zero {
		didSet {
			updateForInsets()
		}
	}

	// used to make the headerview appear to not scroll
	var offsetToCompensateFor = CGPoint.zero {
		didSet {
			updateForInsets()
		}
	}

	// MARK: - Private
	private func setup() {
		backgroundView.accessibilityIgnoresInvertColors = true
		backgroundView.startColor = .statusBackgroundGradientStart
		backgroundView.endColor = .statusBackgroundGradientEnd
		backgroundClipView.addSubviewConstraintToSuperview(backgroundView)

		backgroundClipView.translatesAutoresizingMaskIntoConstraints = false
		backgroundClipView.clipsToBounds = true
		addSubview(backgroundClipView)
		backgroundViewTopConstraint = backgroundClipView.topAnchor.constraint(equalTo: topAnchor)
		NSLayoutConstraint.activate([
			backgroundClipView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundClipView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundClipView.bottomAnchor.constraint(equalTo: bottomAnchor),
			backgroundViewTopConstraint,
		])
		backgroundImageView.contentMode = .bottom
		backgroundImageView.accessibilityIgnoresInvertColors = true
		addSubviewConstraintToSuperview(backgroundImageView)

		let circleInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
		outerCircle.addSubviewConstraintToSuperview(middleCircle, insets: circleInsets)
		middleCircle.addSubviewConstraintToSuperview(innerCircle, insets: circleInsets)
		innerCircle.addSubviewConstraintToSuperview(checkmarkImageView, insets: NSDirectionalEdgeInsets(top: 13, leading: 13, bottom: 13, trailing: 13))
		innerCircle.widthAnchor.constraint(equalToConstant: 64).isActive = true
		outerCircle.backgroundColor = .statusCheckmarkOuterCircle
		middleCircle.backgroundColor = .statusCheckmarkMiddleCircle
		innerCircle.backgroundColor = .statusCheckmarkInnerCircle
		checkmarkImageView.tintColor = .statusCheckmarkIcon
		checkmarkImageView.tintAdjustmentMode = .normal
		innerCircle.accessibilityLabel = NSLocalizedString("status_active_title", comment: "")
		innerCircle.isAccessibilityElement = true
		circleAlignmentView.accessibilityIgnoresInvertColors = true
		circleAlignmentView.addArrangedSubview(outerCircle)

		statusTextLabel.accessibilityTraits.insert(.summaryElement)
		statusTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 260).isActive = true
		labelsStackView.addArrangedSubviews([statusTitleLabel, statusTextLabel])
		labelsAlignmentStackView.addArrangedSubview(.readableContentGuideWrapper(for: labelsStackView))

		 // we add a spacer view at the end that absorbes any extra space, so that the other views can hug vertically
		contentStackView.addArrangedSubviews([circleAlignmentView, labelsAlignmentStackView, UIView()])

		// WORKAROUND(iOS 13, *) using cornerMasks we mis a pixel on the horizontal edges. Our workaround
		// is to wrap the view in a clipping view and make it extend beyond the bottom edge, so that the bottom edges
		// are not visible.
		let bottomDecorationWrapperView = UIView()
		bottomDecorationWrapperView.clipsToBounds = true
		bottomDecorationView.backgroundColor = .systemBackground
		bottomDecorationView.layer.cornerCurve = .continuous
		bottomDecorationView.layer.cornerRadius = 16
		bottomDecorationView.translatesAutoresizingMaskIntoConstraints = false
		bottomDecorationWrapperView.addSubviewConstraintToSuperview(bottomDecorationView, insets: NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: -.defaultSpacing, trailing: 0))
		bottomDecorationWrapperView.heightAnchor.constraint(equalToConstant: .defaultSpacing).isActive = true

		//the contentview clips the backgroundImageView and content, so that when we transform it to stay in its place
		// during scrolling, the background and content don't overflow the other views. It also makes sure we respect the readable content guide.
		contentView.clipsToBounds = true
		contentView.addSubview(backgroundImageView)
		contentView.addSubviewConstraintToReadableContentGuide(contentStackView)
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			backgroundImageView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: -224), // experimentally determined
			backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.defaultSpacing),
		])

		wrapperStackView.addArrangedSubviews([contentView, bottomDecorationWrapperView])
		addSubviewConstraintToSuperview(wrapperStackView)

		NotificationCenter.default.addObserver(self, selector: #selector(reduceMotionStatusDidChange(notification:)), name: UIAccessibility.reduceMotionStatusDidChangeNotification, object: nil)
	}

	private func updateForInsets() {
		// enlarge the background gradient so that it hugs the device top, instead of the safeArea's top and that it extends
		// when we bounce
		backgroundViewTopConstraint.constant = -(insetsToCompensateFor.top + max(0, -offsetToCompensateFor.y - insetsToCompensateFor.top))

		if UIAccessibility.isReduceMotionEnabled == true || alwaysUsesFixedBackground == true {
			// if reduced motion is enabled, the background graphics don't scroll
			let stayInPlaceOffset = (offsetToCompensateFor.y + insetsToCompensateFor.top)
			let transform = CGAffineTransform(translationX: 0, y: stayInPlaceOffset)
			if stayInPlaceOffset <= 0 {
				backgroundImageView.transform = .identity
				backgroundView.transform = .identity
				contentStackView.transform = .identity
				contentView.transform = transform
			} else {
				backgroundImageView.transform = transform
				backgroundView.transform = transform
				contentStackView.transform = transform
				contentView.transform = .identity
			}
		} else {
			backgroundImageView.transform = .identity
			backgroundView.transform = .identity
			contentStackView.transform = .identity
			contentView.transform = .identity
		}
	}

	// MARK: Notification
	@objc private func reduceMotionStatusDidChange(notification: Notification) {
		updateForInsets()
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
