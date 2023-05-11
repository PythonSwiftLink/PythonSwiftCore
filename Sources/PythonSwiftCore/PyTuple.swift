//
//  File.swift
//  
//
//  Created by MusicMaker on 12/10/2022.
//

import Foundation
#if BEEWARE
import PythonLib
#endif


@inlinable public func PyTuple_GetItem<R: ConvertibleFromPython>(_ object: PyPointer?,_ index: Int) throws -> R {
    guard let ptr = PyTuple_GetItem(object, index) else { throw PythonError.attribute }
    defer { Py_DecRef(ptr) }
    return try R(object: ptr)
}

@inlinable public func PyTuple_GetItem(_ object: PyPointer?,_ index: Int) throws -> PyPointer {
    guard let ptr = PyTuple_GetItem(object, index) else { throw PythonError.attribute }
    return ptr
    
}


 
