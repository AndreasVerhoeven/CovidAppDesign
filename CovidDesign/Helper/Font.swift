//
//  Font.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension CustomFontDescriptor {
	static let title = CustomFontDescriptor(pointSize: 22, maximumPointSize: 36, textStyle: .title2, weight: .semibold)
	static let body = CustomFontDescriptor(pointSize: 17, maximumPointSize: 31, textStyle: .body)
	static let tableRow = CustomFontDescriptor(pointSize: 17, maximumPointSize: 31, textStyle: .body, weight: .semibold)
	static let button = CustomFontDescriptor(pointSize: UIFont.buttonFontSize, maximumPointSize: UIFont.buttonFontSize + 14, textStyle: .body, weight: .semibold)

}

// This is a helper struct to aid in dynamic type. Since scaled fonts
// cannot be changed anymore without losing their special scaling abilities,
// we have to introduce an intermediary representation that describes
// all aspects of the font. The properties of this struct can be changed
// easily.
// When we finally need an actual font, call the font() method to
// get a scalable, custom font.
// There's a convenience UIFont.customFont() method, so fonts
// can quickly be instantiated using .customFont(.title).
struct CustomFontDescriptor {
	var name: String? // if nil, uses system font

	var pointSize: CGFloat
	var maximumPointSize: CGFloat? // if defined, will limit the size of scaled fonts

	var textStyle: UIFont.TextStyle? = nil // if defined, used for scaling fonts with UIFontMetrics (otherwise default is used)

	var weight: UIFont.Weight? = nil // if defined, will use the weigth. If .bold, will try to use the bold trait instead
	var design: UIFontDescriptor.SystemDesign? = nil
	var symbolicTraits: UIFontDescriptor.SymbolicTraits? = nil

	var scalability = Scalability.scalable

	enum Scalability {
		case scalable
		case fixed
	}

	func bolder() -> CustomFontDescriptor {
		if let weight = weight {
			return withWeight(weight.bolder())
		} else if symbolicTraits?.contains(.traitBold) == true {
			return withWeight(.heavy)
		} else {
			return withSymbolicTraits(.traitBold)
		}
	}

	func withWeight(_ weight: UIFont.Weight) -> CustomFontDescriptor {
		var item = self
		item.weight = weight
		return item
	}

	func withSymbolicTraits(_ symbolicTraits: UIFontDescriptor.SymbolicTraits) -> CustomFontDescriptor {
		var item = self
		item.symbolicTraits = symbolicTraits
		return item
	}

	func fontMetrics() -> UIFontMetrics {
		return textStyle.map {UIFontMetrics(forTextStyle: $0)} ?? UIFontMetrics.default
	}

	func font() -> UIFont {
		var font: UIFont = name.map {UIFont(name: $0, size: pointSize)!} ?? UIFont.systemFont(ofSize: pointSize)
		if let weight = weight {
			let uiFontDescriptor = font.fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
			font = UIFont(descriptor: uiFontDescriptor, size: 0)
		}

		if let symbolicTraits = symbolicTraits {
			font = UIFont(descriptor: font.fontDescriptor.withSymbolicTraits(symbolicTraits) ?? font.fontDescriptor, size: 0)
		}

		if let design = design {
			font = UIFont(descriptor: font.fontDescriptor.withDesign(design) ?? font.fontDescriptor, size: 0)
		}

		switch scalability {
			case .scalable:
				let metrics = fontMetrics()
				let scaledFont = maximumPointSize.map { metrics.scaledFont(for: font, maximumPointSize: $0) } ?? metrics.scaledFont(for: font)
				return scaledFont

			case .fixed:
			return font
		}
	}
}

extension UIFont.Weight {
	func bolder() -> UIFont.Weight {
		switch self {
			case .ultraLight: return .thin
			case .thin: return .light
			case .light: return .regular
			case .regular: return .medium
			case .medium: return .semibold
			case .semibold: return .bold
			case .bold: return .heavy
			case .heavy: return .black
			case .black: return UIFont.Weight(rawValue: rawValue + 1)
			default: return UIFont.Weight(rawValue: rawValue + 1)
		}
	}
}

extension UIFont {
	static func customFont(_ customFontDescriptor: CustomFontDescriptor) -> UIFont {
		return customFontDescriptor.font()
	}
}
