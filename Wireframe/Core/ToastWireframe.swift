//  Copyright © 2017 cutting.io. All rights reserved.

public protocol ToastWireframeFactory {
    func make(message: String) -> ToastWireframe
}

public protocol ToastWireframe: Viewable {
    var message: String { get }
}
