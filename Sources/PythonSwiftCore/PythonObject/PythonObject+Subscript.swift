//
//  PythonPointer+Subscript.swift
//  metacam
//
//  Created by MusicMaker on 26/02/2022.
//

import Foundation
import CoreGraphics
#if BEEWARE
import PythonLib
#endif



extension PythonObject {
    public subscript(index: Int) -> PyConvertible {
        get {
            PyList_GetItem(ptr, index)
        }
        set {
            PyList_SetItem(ptr, index, newValue.pyPointer)
        }
    }
    
    public var first: PythonObject? {
        if let element = PySequence_GetItem(ptr, 0) {
            return .init(ptr: element, keep_alive: true)
        }
        return nil
    }
}

//extension PythonPointer: Collection {
// 
//    
//    public func index(after i: Int) -> Int {
//        0
//    }
//
//    public typealias Index = Int
//    public var startIndex: Int {
//        0
//    }
//    
//    public var endIndex: Int {
//        PyList_Size(self)
//    }
//    @inlinable
//    public subscript(position: Int) -> PythonPointer {
//        
//        get {
//            if PythonList_Check(self) { PyList_GetItem(self, position) }
//            if PythonTuple_Check(self) { PyTuple_GetItem(self, position)}
//                // Return an appropriate subscript value here.
//            return PythonNone
//            }
//            
//        set {
//            // Perform a suitable setting action here.
//            if PythonList_Check(self) { PyList_SetItem(self, position, newValue) }
//            if PythonTuple_Check(self) { PyTuple_SetItem(self, position, newValue)}
//        }
//    
//    }
//    
//    






