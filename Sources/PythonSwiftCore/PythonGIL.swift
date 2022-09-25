//
//  GIL.swift
//


import Foundation
#if BEEWARE
import PythonLib
#endif

@inlinable
public func withGIL(handle: @escaping ()->Void ) {
    let gil = PyGILState_Ensure()
    handle()
    PyGILState_Release(gil)
}


extension DispatchQueue {
    
    @inlinable
    public func withGIL(handle: @escaping ()->Void ) {
        self.async {
            let gil = PyGILState_Ensure()
            handle()
            PyGILState_Release(gil)
        }
    }
}
