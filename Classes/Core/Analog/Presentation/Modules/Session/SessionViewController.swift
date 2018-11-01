//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import UIKit

public final class SessionViewController: UIViewController {
    
    private enum Constants {
        static let eventCollectionViewCellReuseIdentifier: String = "EventCell"
    }
    
    let session: Session
    
    // MARK: - Subviews
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = true
        return view
    }()
    
    // MARK: - Life cycle
    
    init(session: Session) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        let shareItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonPressed))
        let closeItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeButtonPressed))
        navigationItem.rightBarButtonItems = [closeItem, shareItem]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EventCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.eventCollectionViewCellReuseIdentifier)
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
    
    @objc private func shareButtonPressed() {
        let descriptions = session.events.map { event in
            return event.description.string
        }
        let text = descriptions.joined(separator: "\n\n")
        let shareViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(shareViewController, animated: true)
    }
    
    // MARK: - Private
    
    private func configure(_ cell: EventCollectionViewCell, atIndex index: Int) {
        let event = session.events[index]
        cell.titleLabel.attributedText = event.description
    }
}

// MARK: UICollectionViewDelegate

extension SessionViewController: UICollectionViewDelegate {

}

// MARK: UICollectionViewDataSource

extension SessionViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return session.events.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.eventCollectionViewCellReuseIdentifier, for: indexPath)
        if let cell = cell as? EventCollectionViewCell {
            configure(cell, atIndex: indexPath.row)
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension SessionViewController: UICollectionViewDelegateFlowLayout {
    static let sizeCell = EventCollectionViewCell()
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = type(of: self).sizeCell
        configure(cell, atIndex: indexPath.row)
        return cell.sizeThatFits(.zero)
    }
}
