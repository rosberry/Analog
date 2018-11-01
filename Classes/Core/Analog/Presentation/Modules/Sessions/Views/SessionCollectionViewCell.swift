//
// Copyright (c) 2018 Rosberry. All rights reserved.
//

import UIKit

final class SessionCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let leftInset: CGFloat = 12
        static let topInset: CGFloat = 8
    }
    
    // MARK: Subviews
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Life cycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: Constants.leftInset,
                                  y: Constants.topInset,
                                  width: contentView.bounds.width - 2 * Constants.leftInset,
                                  height: contentView.bounds.height - 2 * Constants.topInset)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelSize = titleLabel.sizeThatFits(.init(width: UIScreen.main.bounds.width - 2 * Constants.leftInset,
                                                      height: .greatestFiniteMagnitude))
        return .init(width: max(labelSize.width + 2 * Constants.leftInset, UIScreen.main.bounds.width),
                     height: labelSize.height + 2 * Constants.topInset)
    }
}
