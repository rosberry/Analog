//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import UIKit
import Analog

final class ViewController: UIViewController {
    
    let logger: Logger = .init()
    
    // MARK: - Subviews
    
    private lazy var simpleEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log simple event", for: .normal)
        button.addTarget(self, action: #selector(simpleEventButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var parameterizedEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log parameterized event", for: .normal)
        button.addTarget(self, action: #selector(parameterizedEventButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var showCurrentSessionLogButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show current session logs", for: .normal)
        button.addTarget(self, action: #selector(showCurrentSessionLogButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var showSessionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show all sessions", for: .normal)
        button.addTarget(self, action: #selector(showSessionsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(simpleEventButton)
        view.addSubview(parameterizedEventButton)
        view.addSubview(showCurrentSessionLogButton)
        view.addSubview(showSessionsButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let inset: CGFloat = 12
        
        simpleEventButton.sizeToFit()
        simpleEventButton.frame.origin = .init(x: inset, y: 100)
        
        parameterizedEventButton.sizeToFit()
        parameterizedEventButton.frame.origin = .init(x: inset, y: simpleEventButton.frame.maxY + inset)
        
        showCurrentSessionLogButton.sizeToFit()
        showCurrentSessionLogButton.frame.origin = .init(x: inset, y: parameterizedEventButton.frame.maxY + inset)
        
        showSessionsButton.sizeToFit()
        showSessionsButton.frame.origin = .init(x: inset, y: showCurrentSessionLogButton.frame.maxY + inset)
    }
    
    // MARK: - Actions
    
    @objc private func simpleEventButtonPressed() {
        logger.log(.init(title: "Simple event"))
    }
    
    @objc private func parameterizedEventButtonPressed() {
        let longDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ac nisi vulputate, dignissim sem sit amet, dignissim sapien. Vestibulum pulvinar, lacus vitae lobortis finibus, orci lorem cursus sapien, vitae vehicula felis erat ut ligula. Nam a augue nec orci dictum venenatis. Nulla ornare rutrum vulputate. Donec vulputate sapien vel elementum commodo. Sed non libero ligula. Integer et velit congue, scelerisque mauris vitae, mattis lacus."
        
        logger.log(.init(title: "Parameterized event", parameters: ["Price": "4",
                                                                    "Quantity": "18",
                                                                    "Notes": longDescription]))
    }
    
    @objc private func showCurrentSessionLogButtonPressed() {
        present(logger.currentEventsModule(), animated: true)
    }
    
    @objc private func showSessionsButtonPressed() {
        present(logger.sessionsModule(), animated: true)
    }
}
