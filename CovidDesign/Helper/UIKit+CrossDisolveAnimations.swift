//
//  UIKit+CrossDisolveAnimations.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension UIView {
	func performTransition(duration: TimeInterval = 0.25, delay: TimeInterval = 0, options: UIView.AnimationOptions = [.beginFromCurrentState, .allowAnimatedContent, .allowUserInteraction, .transitionCrossDissolve], animations: @escaping() -> Void) {
		UIView.transition(with: self, duration: duration, options: options, animations: animations, completion: nil)
	}
}

extension UIImageView {
	func setImage(_ image: UIImage?, animated: Bool = false) {
		guard self.image != image else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setImage(image, animated: false)
			}
		}

		self.image = image
	}

	func setImage(_ image: UIImage?, tintColor: UIColor?, animated: Bool = false) {
		guard self.image != image || self.tintColor != tintColor else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setImage(image, tintColor: tintColor, animated: false)

			}
		}

		self.image = image
		self.tintColor = tintColor
	}
}

extension UILabel {
	func setText(_ text: String?, animated: Bool = false) {
		guard self.text != text else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setText(text, animated: false)
			}
		}

		self.text = text
	}

	func setAttributedText(_ attributedText: NSAttributedString?, animated: Bool = false) {
		guard self.attributedText != attributedText else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setAttributedText(attributedText, animated: false)
			}
		}

		self.attributedText = attributedText
	}

	func setText(_ text: String?, textColor: UIColor?, animated: Bool = false) {
		guard self.text != text || self.textColor != textColor else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setText(text, textColor: textColor, animated: false)
			}
		}

		self.text = text
		self.textColor = textColor
	}
}

extension UITextView {
	func setText(_ text: String?, animated: Bool = false) {
		guard self.text != text else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setText(text, animated: false)
			}
		}

		self.text = text
	}

	func setAttributedText(_ attributedText: NSAttributedString?, animated: Bool = false) {
		guard self.attributedText != attributedText else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setAttributedText(attributedText, animated: false)
			}
		}

		self.attributedText = attributedText
	}

	func setText(_ text: String?, textColor: UIColor?, animated: Bool = false) {
		guard self.text != text || self.textColor != textColor else {return}
		guard animated == false || self.window == nil else {
			return performTransition {
				self.setText(text, textColor: textColor, animated: false)
			}
		}

		self.text = text
		self.textColor = textColor
	}
}

extension UIView {

	func shake(delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
		UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
			UIView.addKeyframe(withRelativeStartTime: 0.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 1.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 2.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 3.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +10, y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 5.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -5,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 6.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +5,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 7.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: -2,  y: 0)})
			UIView.addKeyframe(withRelativeStartTime: 8.0/9.0, relativeDuration: 1.0/9.0, animations: {self.transform = .init(translationX: +2,  y: 0)})

		}, completion: completion)
	}
}
