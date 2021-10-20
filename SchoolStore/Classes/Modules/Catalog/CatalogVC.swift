// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

// MARK: - CatalogVC

final class CatalogVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Catalog.title
        view.addSubview(tableView)
        tableView.top().left().right().bottom()
        catalogService?.getCatalogItems(with: 0, limit: 20, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(products):
                self.items = products
                self.tableView.reloadData()
            case .failure:
                break
            }
        })
    }

    // MARK: Internal

    static let productCellReuseId: String = ProductCell.description()

    var items: [Product] = []

    var catalogService: CatalogService?

    var snacker: Snacker?

//
//    func configTableView() {
//        dataSource = UITableViewDiffableDataSource<SimpleDiffableSection, Producr>(
//            tableView: tableView,
//            cellProvider: { tableView, indexPath, _ -> UITableViewCell? in
//                guard let cell = tableView.dequeueReusableCell(
//                    withIdentifier: Self.productCellReuseId,
//                    for: indexPath
//                ) as? ProductCell else {
//                    return
//                }
//                cell.model = items[indexPath.row]
//                cell.buyHandler = { product in
//                    debugPrint("Buy \(product.id)")
//                }
//            }
//        )
//    }
//
//    func snapshot(_ items: [Product]) {
//        var snapshot = NSDiffableDataSourceSnapshot<SimpleDiffableSection, Product>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(items, toSection: .main)
//        dataSource?.apply(snapshot, animatingDifferences: false)
//    }
//
//    func loadNextPage() {
//        isLoadingNextPage = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.isLoadingNextPage = false
//        }
//    }
//
//    func loadFooterView(load: Bool) {
//        if load {
//            let view = UIView()
//            view.frame.size = .init(width: view.frame.size.width, height: 60)
//            view.startLoading(with: .smallBlue)
//            tableView.tableFooterView = view
//        } else {
//            tableView.tableFooterView = UIView()
//        }
//    }

    // MARK: Private

//
//    private enum SimpleDiffableSection: Int, Hashable {
//        case main
//    }
//
//    private var dataSource: UITableViewDiffableDataSource<SimpleDiffableSection, Producr>?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ProductCell.self,
            forCellReuseIdentifier: Self.productCellReuseId
        )
        return tableView
    }()

//
//    private var isLoadingNextPage: Bool = false {
//        didSet {
//            loadFooterView(load: isLoadingNextPage)
//        }
//    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension CatalogVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.productCellReuseId,
            for: indexPath
        ) as? ProductCell else {
            return UITableViewCell()
        }
        cell.model = items[indexPath.row]
        cell.buyHandler = { product in
            debugPrint("Buy \(product.id)")
        }
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard items.indices.contains(indexPath.row) else {
            return
        }
        catalogService?.getProduct(with: items[indexPath.row].id, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(model):
                debugPrint("Transition to \(model.id)")
                self.navigationController?.pushViewController(VCFactory.buildProductVC(with: model), animated: true)
            case let .failure(error):
                self.snacker?.show(snack: error.localizedDescription, with: .error)
            }
        })
    }

//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
//        guard !isLoadingNextPage else { return }
//        let offset = scrollView.contentOffset.y
//        let height = scrollView.frame.size.height
//        let contentHeight = scrollView.contentSize.height
//
//        if scrollView == tableView {
//            if (offset + height) >= contentHeight {
//                loadNextPage()
//            }
//        }
//    }
}
