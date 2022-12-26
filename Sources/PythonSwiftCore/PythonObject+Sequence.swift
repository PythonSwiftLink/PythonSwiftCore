//
//  File.swift
//  
//
//  Created by MusicMaker on 08/12/2022.
//

import Foundation

#if BEEWARE
import PythonLib
#endif


extension PythonObject: Sequence {
//    __consuming public func makeIterator() -> PySequenceBuffer.Iterator {
//        ptr.getBuffer().makeIterator()
//    }
    
    
    
    @inlinable
    __consuming public func makeIterator() -> Array<PythonObject>.Iterator {
        let fast_list = PySequence_Fast(ptr, nil)
        //PySequence_Fast(UnsafeMutablePointer<PyObject>!, UnsafePointer<CChar>!)
        let list_count = PythonSequence_Fast_GET_SIZE(fast_list)
        let fast_items = PythonSequence_Fast_ITEMS(fast_list)
        let buffer = PySequenceBuffer(start: fast_items, count: list_count)
        //buffer.makeIterator()
        //            defer {
        //                print("Dec Ref \(fast_list)")
        Py_DecRef(fast_list)
        let result: [PythonObject] = buffer.map{.init(getter: $0.xINCREF)}
        return result.makeIterator()
    }
    
//    @inlinable
//    public mutating func next() -> Self? {
//        if let next = iter?.next() {
//            return .init(next)
//        }
//        return nil
//    }
}
