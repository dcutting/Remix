//  Copyright © 2017 cutting.io. All rights reserved.

import Foundation

class AppCoordinator {

    private let navigator: Navigator
    private var discovery: DiscoveryCoordinator?

    init(navigator: Navigator) {
        self.navigator = navigator
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
