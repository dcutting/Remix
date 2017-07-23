//  Copyright © 2017 cutting.io. All rights reserved.

import UIKit

class NavigationAppCoordinator {

    private let navigationCoordinator = UINavigationCoordinator()
    private var discovery: NavigationDiscoveryCoordinator?

    init(window: UIWindow) {
        window.rootViewController = navigationCoordinator.viewController
    }

    func start() {
        let listWireframe = DiscoveryListViewControllerWireframe()
        let detailWireframe = DetailViewControllerWireframe()
        let dependencies = NavigationDiscoveryCoordinatorDependencies(
            navigationCoordinator: navigationCoordinator,
            discoveryListViewWireframe: listWireframe,
            detailViewWireframe: detailWireframe
        )
        discovery = NavigationDiscoveryCoordinator(dependencies: dependencies)
        discovery?.start()
    }
}
