//
//  NSAttributedString+SimpleMarkdown.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 31/05/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

// Quick-and-dirty markdown to NSAttributedString parser for built-in
// localization strings.
extension NSAttributedString {

	convenience init(simpleMarkdownFrom string: String, customFontDescriptor: CustomFontDescriptor) {
		let attributedString = NSMutableAttributedString()

		var isEscaped = false
		var isBold = false
		var isItalic = false
		var isUnderlined = false

		for character in string {
			var ignoreCharacter = false

			if isEscaped == false {
				ignoreCharacter = true
				switch character {
					case "*": isBold.toggle()
					case "/": isItalic.toggle()
					case "_": isUnderlined.toggle()
					case "\\": isEscaped = true
					default: ignoreCharacter = false
				}
			}
			else {
				isEscaped = false
			}

			if ignoreCharacter == false {
				attributedString.append(NSAttributedString(string: String(character)))
				let range = NSRange(location: attributedString.length - 1, length: 1)
				if isUnderlined == true {
					attributedString.addAttribute(.underlineStyle, value: NSNumber(integerLiteral: NSUnderlineStyle.single.rawValue), range: range)
				}

				var customFontDescriptorToUse = customFontDescriptor
				if isBold == true {
					customFontDescriptorToUse = customFontDescriptor.bolder()
				}
				if isItalic == true {
					customFontDescriptorToUse = customFontDescriptor.withSymbolicTraits(.traitItalic)
				}

				attributedString.addAttribute(.font, value: customFontDescriptorToUse.font(), range: range)
			}
		}

		self.init(attributedString: attributedString)
	}

}
