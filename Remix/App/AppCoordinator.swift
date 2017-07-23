//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class AppCoordinator {

    private let navigator = NavigatorController()
    private var discovery: DiscoveryCoordinator?

    init(window: UIWindow) {
        window.rootViewController = navigator.rootViewController
    }

    func start() {
        let listWireframe = DiscoveryListViewControllerWireframe()
        let detailWireframe = DetailViewControllerWireframe()
        let dependencies = DiscoveryCoordinatorDependencies(
            navigator: navigator,
            discoveryListViewWireframe: listWireframe,
            detailViewWireframe: detailWireframe
        )
        discovery = DiscoveryCoordinator(dependencies: dependencies)
        discovery?.start()
    }
}
