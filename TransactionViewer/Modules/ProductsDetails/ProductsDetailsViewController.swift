//
//  ProductsDetailsCellViewController.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import UIKit

protocol ProductsDetailsViewControllerProtocol: AnyObject {
    func setTotalAmount(amount: String)
}

class ProductsDetailsViewController: UIViewController {
    // MARK: - Public properties
    var presenter: ProductsDetailsPresenterProtocol

    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var totalAmountLabel: UILabel = {
        let view = UILabel()
        //view.text = "Total: "
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init
    init(presenter: ProductsDetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController's methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
        configureUI()
        presenter.viewDidLoad()
    }

    // MARK: - Public Methods
    func setTotalAmount(amount: String) {
        totalAmountLabel.text = "Total: £\(amount)"
    }

    // MARK: - Private methods
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        title = Constants.title
    }

    private func configureUI() {
        view.addSubview(totalAmountLabel)
        view.addSubview(tableView)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        NSLayoutConstraint.activate([
            totalAmountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            totalAmountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.defaultInset),
            totalAmountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.defaultInset),
            tableView.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.defaultInset),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.defaultInset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProductsDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.transactions?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { return UITableViewCell() }

        let convertedValues = presenter.getConvertedValuesIfNeeded(indexPath: indexPath)
        cell.setupLabels(productName: convertedValues.inputAmount, productCount: "£\(convertedValues.convertedAmount)")

        return cell
    }
}

// MARK: - ProductsDetailsViewControllerProtocol
extension ProductsDetailsViewController: ProductsDetailsViewControllerProtocol {
    
}

// MARK: - Constants
private enum Constants {
    static let defaultInset: CGFloat = 12
    static let title: String = "Products details"
}
