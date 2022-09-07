//
//  UILabel.swift
//  CryptoApp
//
//  Created by Yunus Emre Koca on 7.09.2022.
//

import UIKit

extension UILabel {
    func getLineCount() -> Int {
        guard let myText = self.text as NSString? else { return 0 }
        layoutIfNeeded()
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
}
