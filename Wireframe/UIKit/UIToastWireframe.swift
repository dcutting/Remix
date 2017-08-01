//  Copyright © 2017 cutting.io. All rights reserved.

public class UIToastWireframeFactory: ToastWireframeFactory {

    public init() {}
    
    public func make(message: String) -> ToastWireframe {
        return UIAlertController(title: message, message: nil, preferredStyle: .alert)
    }
}

extension UIAlertController: ToastWireframe {
    public var message: String {
        return title ?? ""
    }
}
