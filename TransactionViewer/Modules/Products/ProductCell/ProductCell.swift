//
//  ProductCell.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import UIKit

class ProductCell: UITableViewCell {
    // MARK: - Public Properties
    var leftLabelText: String? {
        leftLabel.text
    }

    var rightLabelText: String? {
        rightLabel.text
    }

    // MARK: - Private properties
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()

    private lazy var leftLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var rightLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        return view
    }()

    //MARK: - Initializers
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            configureCell()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    // MARK: - Cell's methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public methods
    func setupLabels(productName: String?, productCount: String?) {
        leftLabel.text = productName
        rightLabel.text = "\(productCount ?? "0")"
    }

    // MARK: - Private methods
    private func configureCell() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.contentInset),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.contentInset)
        ])
    }
}

extension ProductCell {
    static var identifier: String {
        return String(describing: type(of: Self.self))
    }
}

private enum Constants {
    static let contentInset: CGFloat = 12
}
