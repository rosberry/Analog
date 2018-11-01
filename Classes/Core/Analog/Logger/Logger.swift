//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import UIKit

public final class Logger {
    
    lazy var sessions: [Session] = {
        return restoredSessions()
    }()
    private static let sharedSession: Session = .init()
    var currentSession: Session {
        return Logger.sharedSession
    }
    
    private static let notificationsSubscriber: NotificationsSubscriber = {
        return NotificationsSubscriber(notification: UIApplication.willResignActiveNotification) {
            Logger.saveCurrentSession()
        }
    }()
    
    public init() {
    
    }
    
    public func log(_ event: Event) {
        currentSession.events.insert(event, at: 0)
    }
    
    public func currentEventsModule() -> UIViewController {
        let viewController = SessionViewController(session: currentSession)
        return UINavigationController(rootViewController: viewController)
    }
    
    // MARK: - Private
    
    private func restoredSessions() -> [Session] {
        var sessions: [Session] = []
        do {
            let sessionsFolderURL = try Logger.sessionsFolderURL()
            let rawSessions = try FileManager.default.contentsOfDirectory(atPath: sessionsFolderURL.path)
            sessions = rawSessions.compactMap { fileName in
                let fileURL = sessionsFolderURL.appendingPathComponent(fileName)
                do {
                    return try JSONDecoder().decode(Session.self, from: try Data(contentsOf: fileURL))
                }
                catch {
                    return nil
                }
            }
        }
        catch {}
        return sessions
    }
    
    private static func saveCurrentSession() {
        do {
            let data = try JSONEncoder().encode(sharedSession)
            
            let sessionFileURL = try sessionsFolderURL().appendingPathComponent("\(sharedSession.uuid.uuidString)")
            if FileManager.default.fileExists(atPath: sessionFileURL.path) {
                try FileManager.default.removeItem(atPath: sessionFileURL.path)
            }
            FileManager.default.createFile(atPath: sessionFileURL.path, contents: data)
        }
        catch {
            // need warning log message
        }
    }
    
    // MARK: - Paths
    
    private static func sessionsFolderURL() throws -> URL {
        let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let folderURL = documentsURL.appendingPathComponent("Analog/Sessions")
        return folderURL
    }
}

// MARK: - NotificationsSubscriber

private final class NotificationsSubscriber {
    
    private let notificationHandler: (() -> Void)
    
    init(notification: Notification.Name, handler: @escaping (() -> Void)) {
        self.notificationHandler = handler
        NotificationCenter.default.addObserver(self, selector: #selector(notificationFired), name: notification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func notificationFired() {
        notificationHandler()
    }
}
