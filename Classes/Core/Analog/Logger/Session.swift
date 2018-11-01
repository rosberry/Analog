//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import Foundation

final class Session: Codable {
    var events: [Event] = []
    let uuid: UUID = .init()
}

// MARK: AttributedStringConvertible

extension Session: AttributedStringConvertible {
    
    public var description: NSAttributedString {
        let fontSize: CGFloat = 14
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .long
        
        let titleString = NSAttributedString(string: "📝 Session",
                                             attributes: [.font: UIFont.boldSystemFont(ofSize: fontSize + 2)])
        let finalString = NSMutableAttributedString(attributedString: titleString)
        
        finalString.append(.lineBreakString(fontSize: fontSize))
        finalString.append(.parameterString(title: "UUID", value: uuid.uuidString, fontSize: fontSize))
        
        finalString.append(.lineBreakString(fontSize: fontSize))
        finalString.append(.parameterString(title: "Events count", value: "\(events.count)", fontSize: fontSize))
        
        if events.count == 1 {
            finalString.append(.lineBreakString(fontSize: fontSize))
            finalString.append(.parameterString(title: "Date", value: "[\(formatter.string(from: events[0].date))]", fontSize: fontSize))
        }
        else if events.count > 1,
                let firstDate = events.first?.date,
                let lastDate = events.last?.date {
            finalString.append(.lineBreakString(fontSize: fontSize))
            finalString.append(.parameterString(title: "Start date", value: "[\(formatter.string(from: firstDate))]", fontSize: fontSize))
            finalString.append(.lineBreakString(fontSize: fontSize))
            finalString.append(.parameterString(title: "End date", value: "[\(formatter.string(from: lastDate))]", fontSize: fontSize))
        }
        
        return finalString
    }
}

// MARK: Comparable

extension Session: Comparable {
    public static func <(lhs: Session, rhs: Session) -> Bool {
        if lhs.events.count > 0,
           rhs.events.count > 0 {
            return lhs.events[0].date < rhs.events[0].date
        }
        return true
    }
}

// MARK: Equatable

extension Session: Equatable {
    public static func ==(lhs: Session, rhs: Session) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
