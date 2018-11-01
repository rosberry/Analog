//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import UIKit

final class SessionsViewController: UIViewController {
    
    private enum Constants {
        static let sessionCollectionViewCellReuseIdentifier: String = "SessionCell"
    }
    
    private let sessions: [Session]
    
    // MARK: Subviews
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = true
        return view
    }()
    
    // MARK: Life cycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sessions: [Session]) {
        self.sessions = sessions
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let closeItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeButtonPressed))
        navigationItem.rightBarButtonItem = closeItem
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SessionCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.sessionCollectionViewCellReuseIdentifier)
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: - Actions
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true)
    }
    
    // MARK: - Private
    
    private func configure(_ cell: SessionCollectionViewCell, atIndex index: Int) {
        let session = sessions[index]
        cell.titleLabel.attributedText = session.description
    }
}

// MARK: UICollectionViewDelegate

extension SessionsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sessionViewController = SessionViewController(session: sessions[indexPath.row])
        navigationController?.show(sessionViewController, sender: nil)
    }
}

// MARK: UICollectionViewDataSource

extension SessionsViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.sessionCollectionViewCellReuseIdentifier,
                                                      for: indexPath)
        if let cell = cell as? SessionCollectionViewCell {
            configure(cell, atIndex: indexPath.row)
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension SessionsViewController: UICollectionViewDelegateFlowLayout {
    static let sizeCell = SessionCollectionViewCell()
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = type(of: self).sizeCell
        configure(cell, atIndex: indexPath.row)
        return cell.sizeThatFits(.zero)
    }
}
