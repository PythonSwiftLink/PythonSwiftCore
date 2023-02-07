////
////  CustomPyObject.swift
////  touchBay editor
////
////  Created by MusicMaker on 16/09/2022.
////
//
//import Foundation
//
//#if BEEWARE
//import PythonLib
//#endif
////import PythonSwiftCore
////#endif
//
////
////func PyArg_VectorcallUnpack<A: PyConvertible,B: PyConvertible,C: PyConvertible>(_ args: VectorArgs) -> (A?,B?,C?) {
////    (
////        A.init,
////        B.init(args?[1]),
////        C.init(args?[2])
////    )
////}
////
////@inlinable
////func PyArg_VectorcallUnpack<A: PyConvertible,B: PyConvertible,C: PyConvertible,D: PyConvertible>(_ args: VectorArgs) -> (A?,B?,C?,D?) {
////
////    (
////        A.init(args?[0]),
////        B.init(args?[1]),
////        C.init(args?[2]),
////        D.init(args?[3])
////    )
////}
////func PyArg_IntUnpack(_ args: VectorArgs) -> (Int?,Int?,Int?,Int?) {
////    (
////        PyLong_AsLong(args?[0]),
////        PyLong_AsLong(args?[1]),
////        PyLong_AsLong(args?[2]),
////        PyLong_AsLong(args?[3])
////    )
////}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//extension PySwiftObjectPointer {
//
//    func releaseSwiftPointer<T: AnyObject>(_ value: T.Type) {
//        if let ptr = self?.pointee.swift_ptr {
//            Unmanaged<T>.fromOpaque(ptr).release()
//        }
//    }
//
//    //    func setSwiftPointer<T: AnyObject>(_ value: T) {
//    //        self?.pointee.swift_ptr = Unmanaged.passRetained(value).toOpaque()
//    //    }
//}
//
//extension PythonPointer {
//
//    var pyswift_cls: PySwiftObject { PySwiftObject_Cast(self).pointee }
//
//
//
////    func getSwiftPointer<T: Hashable>() -> T {
////        let ptr = PySwiftObject_Cast(self).pointee.swift_ptr!
////        return ptr.assumingMemoryBound(to: T.self).pointee
////    }
////
////    //
////    //    func getSwiftPointer<T: AnyObject>() -> T {
////    //        return Unmanaged<T>.fromOpaque(
////    //            PySwiftObject_Cast(self).pointee.swift_ptr
////    //        ).takeUnretainedValue()
////    //    }
////
////    func setSwiftPointer_cls<T: AnyObject>(_ value: T) {
////        PySwiftObject_Cast(self).pointee.swift_ptr = Unmanaged.passUnretained(value).toOpaque()
////    }
////
////    func setSwiftPointer<T: Hashable>(_ value: T) {
////        let ptr: UnsafeMutablePointer<T> = .allocate(capacity: 1)
////        ptr.pointee = value
////        PySwiftObject_Cast(self).pointee.swift_ptr = .init(ptr)
////    }
////    //
////    //    func setSwiftPointer<T: AnyObject>(_ value: T) {
////    //        PySwiftObject_Cast(self).pointee.swift_ptr = Unmanaged.passRetained(value).toOpaque()
////    //    }
//
//    func releaseSwiftPointer<T: AnyObject>(_ value: T.Type) {
//        PySwiftObject_Cast(self).releaseSwiftPointer(value)
//    }
//
//    //    func releaseSwiftPointer<T: AnyObject>() {
//    ////        Unmanaged<T>.fromOpaque(
//    ////            PySwiftObject_Cast(self).pointee.swift_ptr
//    ////        )
//    //    }
//}
