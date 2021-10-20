// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

final class ProductVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToSuperview()
        contentView.pinToSuperview().width(as: scrollView)

        scrollView
            .heightAnchor
            .constraint(lessThanOrEqualTo: contentView.heightAnchor)
            .activate()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: Internal

    var product: Product? {
        didSet {
            contentView.fillWith(product: product)
        }
    }

    // MARK: Private

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: ProductView = {
        let contentView = ProductView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
}
