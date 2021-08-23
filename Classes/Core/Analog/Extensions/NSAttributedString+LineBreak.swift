//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import UIKit

extension NSAttributedString {
    static func lineBreakString(fontSize: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: "\n", attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
    }
    
    static func parameterString(title: String, value: String, fontSize: CGFloat) -> NSAttributedString {
        let finalString = NSMutableAttributedString(string: "\(title)",
                                                    attributes: [.font: UIFont.boldSystemFont(ofSize: fontSize),
                                                                 .foregroundColor: UIColor.black])
        finalString.append(.init(string: ": \(value)",
                                 attributes: [.font: UIFont.systemFont(ofSize: fontSize),
                                              .foregroundColor: UIColor.black]))
        return finalString
    }
}
