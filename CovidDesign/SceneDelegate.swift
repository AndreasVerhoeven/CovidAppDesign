//
//  SceneDelegate.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		guard let window = window else {return}
		window.rootViewController = ThemedNavigationController(rootViewController: OnboardingIntroViewController())
		//window.rootViewController = StatusNavigationController()
		window.makeKeyAndVisible()
	}
}

