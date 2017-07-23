//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class NavigatorAppCoordinator {

    private let navigator = NavigatorController()
    private var discovery: NavigatorDiscoveryCoordinator?

    init(window: UIWindow) {
        window.rootViewController = navigator.viewController
    }

    func start() {
        let listWireframe = DiscoveryListViewControllerWireframe()
        let detailWireframe = DetailViewControllerWireframe()
        let dependencies = NavigatorDiscoveryCoordinatorDependencies(
            navigator: navigator,
            discoveryListViewWireframe: listWireframe,
            detailViewWireframe: detailWireframe
        )
        discovery = NavigatorDiscoveryCoordinator(dependencies: dependencies)
        discovery?.start()
    }
}
