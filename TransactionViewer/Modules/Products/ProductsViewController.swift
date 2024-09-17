//
//  ViewController.swift
//  TransactionViewer
//
//  Created by Липатов Константин Евгеньевич on 17.09.2024.
//

import UIKit

class ProductsViewController: UIViewController {
    //MARK: - Public properties
    var presenter: ProductsPresenterProtocol

    // MARK: - Private properties
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Init
    init(presenter: ProductsPresenterProtocol) {
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
        configureTableView()
        presenter.viewDidLoad()
    }

    // MARK: - Private methods
    private func setupViewController() {
        view.backgroundColor = .systemBackground
        title = Constants.title
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.leftTableInset),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.leftTableInset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else { return UITableViewCell() }

        let products = presenter.products
        if let product = products[safe: indexPath.row],
           let transactionsCount = presenter.getTransactionCountForProduct(productName: product) {
            cell.setupLabels(productName: product, productCount: "\(transactionsCount)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

private enum Constants {
    static let leftTableInset: CGFloat = 12
    static let title: String = "Products"
}
