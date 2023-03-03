

import Foundation
#if BEEWARE
import PythonLib
#endif

//public protocol PyConvertible {
//    
//    var pyObject: PythonObject { get }
//    var pyPointer: PyPointer { get }
//}
//
//
//public protocol ConvertibleFromPython {
//
////    init(_ object: PythonObject)
////    init?(_ ptr: PyPointer)
//    init(object: PyPointer) throws
//}

public protocol ConvertibleFromPython_WithCheck {
    init?(withCheck p: PyPointer)
}











extension Error {
    public var pyPointer: PyPointer {
        localizedDescription.pyPointer
    }
}
extension Optional where Wrapped == Error {
    public var pyPointer: PyPointer {
        if let this = self {
            return this.localizedDescription.pyPointer
        }
        return .PyNone
    }
}
