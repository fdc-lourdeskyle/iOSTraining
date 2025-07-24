//
//  FilterCell.swift
//  iOSTraining
//
//  Created by FDC-LOURDES-NC-WEB on 7/24/25.
//

import UIKit

class FilterCell: UICollectionViewCell {
    static let filterCellIdentifier = "FilterCell"

    let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder){
        super.init(coder: coder)
        setupButton()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isSelected = false
    }

    private func setupButton() {
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .clear
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 12, bottom: 14, trailing: 12)
        button.configuration = config

        button.isUserInteractionEnabled = false
    }

    func configure(with title: String) {
        var config = button.configuration ?? UIButton.Configuration.plain()
        config.title = title
        button.configuration = config
    }

    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return }
            var config = button.configuration
            config?.background.backgroundColor = isSelected ? .white : .clear
            config?.baseForegroundColor = isSelected ? .black : .white
            button.configuration = config
            print("Selection changed to:", isSelected)
        }
    }
}
