//
//  UIImage+Helper.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension UIImage {
	// renders a symbol into a circle
	static func circle(with systemName: String, color: UIColor, size: CGFloat) -> UIImage? {
		guard let image = UIImage(systemName: systemName) else {return nil}

		let metrics = UIFontMetrics(forTextStyle: .body)
		let scaledSize = min(metrics.scaledValue(for: size), size + 4)
		let inset = CGFloat(6)

		let rect = CGRect(x: 0, y: 0, width: scaledSize, height: scaledSize)
		return UIGraphicsImageRenderer(size: rect.size).image { context in
			color.setFill()
			UIBezierPath(ovalIn: rect).fill()
			image.withTintColor(.white).draw(in: rect.insetBy(dx: inset, dy: inset))
		}
	}
}
