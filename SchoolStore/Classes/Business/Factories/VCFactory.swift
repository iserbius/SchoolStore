// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vc = StoryboardScene.Auth.initialScene.instantiate()
        let authService = CoreFactory.buildAuthService()
        vc.setup(with: authService)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        StoryboardScene.TabBar.initialScene.instantiate()
    }
}
