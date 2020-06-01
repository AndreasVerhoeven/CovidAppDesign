//
//  UILabel+Helper.swift
//  CovidDesign
//
//  Created by Andreas Verhoeven on 01/06/2020.
//  Copyright © 2020 Andreas Verhoeven. All rights reserved.
//

import UIKit

extension UILabel {

	convenience init(font: UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize),
					 textColor: UIColor? = nil,
					 textAlignment: NSTextAlignment = .natural,
					 numberOfLines: Int = 0,
					 adjustsFontForContentSizeCategory: Bool = true) {
		self.init(frame: .zero)
		self.font = font
		self.textColor = textColor
		self.textAlignment = textAlignment
		self.numberOfLines = numberOfLines
		self.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory
	}

	convenience init(customFontDescriptor: CustomFontDescriptor,
					 textColor: UIColor? = nil,
					 textAlignment: NSTextAlignment = .natural,
					 numberOfLines: Int = 0) {
		var adjustsFontForContentSizeCategory: Bool = false
		switch customFontDescriptor.scalability {
			case .scalable: adjustsFontForContentSizeCategory = true
			case .fixed: adjustsFontForContentSizeCategory = false
		}

		self.init(font: customFontDescriptor.font(),
				  textColor: textColor,
				  textAlignment: textAlignment,
				  numberOfLines: numberOfLines,
				  adjustsFontForContentSizeCategory: adjustsFontForContentSizeCategory)
	}
}
