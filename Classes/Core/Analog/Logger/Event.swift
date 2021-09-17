//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import Foundation

public final class Event: Codable {
    private let title: String
    private let parameters: [String: String]?
    let date: Date
    
    public init(title: String, parameters: [String: String]? = nil) {
        self.title = title
        self.parameters = parameters
        self.date = .init()
    }
}

// MARK: CustomStringConvertible

extension Event: AttributedStringConvertible {
    
    public var description: NSAttributedString {
        let fontSize: CGFloat = 14
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        let dateString = NSAttributedString(string: "✏️ [\(formatter.string(from: date))]",
                                            attributes: [.font: UIFont.systemFont(ofSize: fontSize),
                                                         .foregroundColor: UIColor.black])
        let finalString = NSMutableAttributedString(attributedString: dateString)
        let titleString = NSAttributedString(string: "\(title)",
                                             attributes: [.font: UIFont.boldSystemFont(ofSize: fontSize + 2),
                                                          .foregroundColor: UIColor.black])
        finalString.append(.lineBreakString(fontSize: fontSize))
        finalString.append(titleString)
        
        if let parameters = parameters,
           parameters.count > 0 {
            finalString.append(.lineBreakString(fontSize: fontSize))
            parameters.forEach { key, value in
                finalString.append(.parameterString(title: key, value: value, fontSize: fontSize))
                finalString.append(.lineBreakString(fontSize: fontSize))
            }
        }
        
        return finalString
    }
}
