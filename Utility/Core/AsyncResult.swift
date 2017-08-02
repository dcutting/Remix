//  Copyright © 2017 cutting.io. All rights reserved.

public enum AsyncResult<SuccessType> {
    case success(SuccessType)
    case error
}
