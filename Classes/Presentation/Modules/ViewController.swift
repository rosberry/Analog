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
        return button
    }()
    
    private lazy var parameterizedEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log parameterized event", for: .normal)
        return button
    }()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(simpleEventButton)
        view.addSubview(parameterizedEventButton)
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
    }
}
