//
//  String+extensions.swift
//  Weather
//
//  Created by Артур Кононович on 17.06.21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
