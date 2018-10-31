//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import Foundation

final class Session: Codable {
    var events: [Event] = []
    let uuid: UUID = .init()
}
