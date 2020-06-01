//
//  UIWindow+Helper.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit


extension UIWindow {
	// It's all about animation
	func switchRootViewController(_ viewController: UIViewController,  animated: Bool = true, duration: TimeInterval = 0.35, options: UIView.AnimationOptions = [.allowAnimatedContent, .allowUserInteraction, .beginFromCurrentState, .transitionCrossDissolve], completion: (() -> Void)? = nil) {
		guard animated else {
			rootViewController = viewController
			return
		}

		UIView.transition(with: self, duration: duration, options: options, animations: {
			UIView.performWithoutAnimation {
				self.rootViewController = viewController
			}
		}) { _ in
			completion?()
		}
	}
}
