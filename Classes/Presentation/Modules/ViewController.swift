//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import UIKit
import Analog

final class ViewController: UIViewController {
    
    let logger: Logger = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        show(logger.currentEventsModule(), sender: nil)
    }
}
