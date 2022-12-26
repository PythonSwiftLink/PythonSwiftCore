////
////  File.swift
////  
////
////  Created by MusicMaker on 24/09/2022.
////
//
//import Foundation
//#if BEEWARE
//import PythonLib
//#endif
//
//public protocol PyConvertible {
//    init?(_ o: PythonPointer)
//}
//
//extension PythonPointer: PyConvertible {
//    public init?(_ o: PythonPointer) {
//        self = o
//    }
//}
//
//extension Int: PyConvertible {
//    @inlinable
//    public init?(_ o: PythonPointer) { self = PyLong_AsLong(o) }
//}
//
//extension Double: PyConvertible {
//    @inlinable
//    public init?(_ o: PythonPointer) { self = PyFloat_AsDouble(o) }
//}
//
//extension String: PyConvertible {
//    @inlinable
//    public init?(_ o: PythonPointer) {
//        guard let ptr = PythonUnicode_DATA(o) else { return nil }
//                
//        let kind = PythonUnicode_KIND(o)
//        let length = PyUnicode_GetLength(o)
//        var size: Int
//        switch PythonUnicode_Kind(rawValue: kind) {
//        case .PyUnicode_WCHAR_KIND:
//            return nil
//        case .PyUnicode_1BYTE_KIND:
//            size = length * MemoryLayout<Py_UCS1>.stride
//            let data = Data(bytesNoCopy: ptr, count: size, deallocator: .none)
//            //self = String(data: data, encoding: .utf8)
//            self.init(data: data, encoding: .utf8)
//        case .PyUnicode_2BYTE_KIND:
//            size = length * MemoryLayout<Py_UCS2>.stride
//            let data = Data(bytesNoCopy: ptr, count: size, deallocator: .none)
//            self.init(data: data, encoding: .utf16LittleEndian)
//        case .PyUnicode_4BYTE_KIND:
//            size = length * MemoryLayout<Py_UCS4>.stride
//            let data = Data(bytesNoCopy: ptr, count: size, deallocator: .none)
//            self.init(data: data, encoding: .utf32LittleEndian)
//        case .none:
//            print(".none",kind)
//            return nil
//        }
//    }
//}
