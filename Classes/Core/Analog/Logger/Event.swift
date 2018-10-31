//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import Foundation

public final class Event: Codable {
    private let title: String
    private let parameters: [String: String]
    private let date: Date
    
    init(title: String, parameters: [String: String]) {
        self.title = title
        self.parameters = parameters
        self.date = .init()
    }
}
