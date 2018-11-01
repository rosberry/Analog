//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import Foundation

public final class Event: Codable {
    private let title: String
    private let parameters: [String: String]?
    private let date: Date
    
    public init(title: String, parameters: [String: String]? = nil) {
        self.title = title
        self.parameters = parameters
        self.date = .init()
    }
}

// MARK: CustomStringConvertible

extension Event: AttributedStringConvertible {
    
    public var description: NSAttributedString {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        let parametersDescriptions = parameters?.map { key, value in
            return "\(key): \(value)"
        }
        
        let fontSize: CGFloat = 14
        
        let dateString = NSAttributedString(string: "✏️ [\(formatter.string(from: date))]",
                                            attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
        let finalString = NSMutableAttributedString(attributedString: dateString)
        let titleString = NSAttributedString(string: "\(title)",
                                             attributes: [.font: UIFont.boldSystemFont(ofSize: fontSize)])
        finalString.append(lineBreakString(fontSize: fontSize))
        finalString.append(titleString)
        
        if let parametersDescriptions = parametersDescriptions,
           parametersDescriptions.count > 0 {
            let parametersString = NSAttributedString(string: parametersDescriptions.joined(separator: "\n"),
                                                      attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
            finalString.append(lineBreakString(fontSize: fontSize))
            finalString.append(parametersString)
        }
        
        return finalString
    }
    
    // MARK: - Private
    
    private func lineBreakString(fontSize: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: "\n", attributes: [.font: UIFont.systemFont(ofSize: fontSize)])
    }
}
