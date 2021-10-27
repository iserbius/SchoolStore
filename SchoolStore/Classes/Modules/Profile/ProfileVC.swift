// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Internal

    var dataService: DataService?

    @objc
    func specializationDidTap(_ sender: UIButton) {
        print(sender.titleLabel?.text)
    }

    @IBAction func editProfilePressed(_: Any) {
        let array = [
            "Разработчик",
            "Тестировщик",
            "Строитель",
            "Продавец",
        ]
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        array.forEach { specialization in
            let button = UIButton()
            button.height(44)
            button.setTitleColor(.blue, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(specialization, for: .normal)
            button.addTarget(self, action: #selector(specializationDidTap), for: .touchUpInside)
            view.addArrangedSubview(button)
        }
        let vc = VCFactory.buildBottomSheetController(
            with: view,
            onEveryTapOut: nil
        )
        present(vc, animated: true, completion: nil)
    }

    @IBAction func logoutPressed(_: Any) {
        dataService?.appState.accessToken = nil
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }

    // MARK: Private

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
