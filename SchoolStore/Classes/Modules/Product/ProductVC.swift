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
        contentView.pinToSuperview()
            .width(as: scrollView)

        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        button.center().width(100).height(50)
        button.backgroundColor = .red
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

    @objc
    private func action() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.height(100)
        view.backgroundColor = .red
        let vc = VCFactory.buildBottomSheetController(with: view, onEveryTapOut: nil)
        present(vc, animated: true, completion: nil)
    }
}
