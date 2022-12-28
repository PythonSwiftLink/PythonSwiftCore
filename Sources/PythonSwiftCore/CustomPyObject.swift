//
//  CustomPyObject.swift
//  touchBay editor
//
//  Created by MusicMaker on 16/09/2022.
//

import Foundation
//#if os(OSX)
#if BEEWARE
import PythonLib

#endif
//import PythonSwiftCore
import CoreMedia
//#endif

//
//func PyArg_VectorcallUnpack<A: PyConvertible,B: PyConvertible,C: PyConvertible>(_ args: VectorArgs) -> (A?,B?,C?) {
//    (
//        A.init,
//        B.init(args?[1]),
//        C.init(args?[2])
//    )
//}
//
//@inlinable
//func PyArg_VectorcallUnpack<A: PyConvertible,B: PyConvertible,C: PyConvertible,D: PyConvertible>(_ args: VectorArgs) -> (A?,B?,C?,D?) {
//
//    (
//        A.init(args?[0]),
//        B.init(args?[1]),
//        C.init(args?[2]),
//        D.init(args?[3])
//    )
//}
//func PyArg_IntUnpack(_ args: VectorArgs) -> (Int?,Int?,Int?,Int?) {
//    (
//        PyLong_AsLong(args?[0]),
//        PyLong_AsLong(args?[1]),
//        PyLong_AsLong(args?[2]),
//        PyLong_AsLong(args?[3])
//    )
//}

public class PyMethodDefWrap {
    
    
    
    
    
    public struct Flags: RawRepresentable {
        public var rawValue: Int32
        
        public typealias RawValue = Int32
        
        public static let NOARGS = Flags(rawValue: METH_NOARGS)!
        public static let VARARGS = Flags(rawValue: METH_VARARGS)!
        public static let KEYWORDS = Flags(rawValue: METH_KEYWORDS)!
        
        public static let O = Flags(rawValue: METH_O)!
        public static let CLASS = Flags(rawValue: METH_CLASS)!
        public static let STATIC = Flags(rawValue: METH_STATIC)!
        public static let COEXIST = Flags(rawValue: METH_COEXIST)!
        public static let FASTCALL = Flags(rawValue: METH_FASTCALL)!
        public static let METHOD = Flags(rawValue: METH_METHOD)!

        public static let FAST_KEYWORDS: Flags = FASTCALL | KEYWORDS
        
        public static let METHOD_FAST_KEYWORDS: Flags = METHOD | FASTCALL | KEYWORDS
//        static let CLASS_NOARGS: Flags = CLASS | NOARGS
//        static let CLASS_VARARGS: Flags = CLASS | VARARGS
//        static let CLASS_KEYWORDS: Flags = CLASS | KEYWORDS
//
//        static let CLASS_FAST_VARARGS: Flags = CLASS | FASTCALL | VARARGS
//        static let CLASS_FAST_KEYWORDS: Flags = CLASS | FASTCALL | KEYWORDS
        
        public init?(rawValue: Int32) {
            self.rawValue = rawValue
        }

        
        public static func |(lhs: Flags, rhs: Flags) -> Int32 {
            return lhs.rawValue | rhs.rawValue
        }
        public static func |(lhs: Flags, rhs: Flags) -> Flags {
            return .init(rawValue: lhs.rawValue | rhs.rawValue)!
        }
    }
    
    let method_name: UnsafePointer<CChar>
    let doc_string: UnsafePointer<CChar>!
    let pyMethod: PyMethodDef
    
    public convenience init(noArgs name: String,_ function: PyCFunc) {
        self.init(name: name, flag: .NOARGS, doc: nil, meth: function)
    }
    
    public convenience init(withArgs name: String, function: PyCVectorCall) {
        self.init(name: name, flag: .FASTCALL, doc: nil, meth: PyCFunctionFast_Cast(function))
    }
    
    public convenience init(oneArg name: String, function: PyCFunc) {
        self.init(name: name, flag: .O, doc: nil, meth: function)
    }
    
    public convenience init(withKeywords name: String, function: PyCVectorCallKeywords) {
        self.init(name: name, flag: .FAST_KEYWORDS, doc: nil, meth: PyCFunctionFastWithKeywords_Cast(function))
    }
    
    public convenience init(methodWithKeywords name: String, function: PyCMethodVectorCall) {
        self.init(name: name, flag: .FAST_KEYWORDS, doc: nil, meth: PyCMethod_Cast(function))
    }
    
    public init(name: String, flag: Flags = .FASTCALL, doc: String? = nil, meth: PyCFunc) {
        let method_name: UnsafePointer<Int8> = makeCString(from: name)
        var doc_string: UnsafePointer<Int8>? = nil
        if let doc = doc {
            doc_string = doc.withCString { ptr in
                    .init(ptr)
            }
        }
        
        self.method_name = method_name
        self.doc_string = doc_string
        
        pyMethod = .init(
            ml_name: method_name,
            ml_meth: meth,
            ml_flags: flag.rawValue,
            ml_doc: doc_string
        )
    }
    
    deinit {
        method_name.deallocate()
        doc_string.deallocate()
    }
}

public class PyMethodDefHandler {
    
    let methods_ptr: UnsafeMutablePointer<PyMethodDef>
    var methods_container: [PyMethodDefWrap]
    
    public init(methods: [PyMethodDefWrap]) {
        
        methods_container = methods
        let count = methods.count
        methods_ptr = .allocate(capacity: count + 1)
        for (i, meth) in methods.enumerated() {
            methods_ptr[i] = meth.pyMethod
        }
        methods_ptr[count] = .init()
    }
    
    public init(_ methods: PyMethodDefWrap... ) {
        methods_container = methods
        let count = methods.count
        methods_ptr = .allocate(capacity: count + 1)
        for (i, meth) in methods.enumerated() {
            methods_ptr[i] = meth.pyMethod
        }
        methods_ptr[count] = .init()
    }
    
    
    deinit {
        methods_ptr.deallocate()
    }
}

public class PySequenceMethodWrap {
    
    
    
    let length: PySequence_Length_func
    let concat: PySequence_Concat_func
    let repeat_: PySequence_Repeat_func
    let get_item: PySequence_Item_func
    let set_item: PySequence_Ass_Item_func
    let contains: PySequence_Contains_func
    let inplace_concat: PySequence_Inplace_Concat_func
    let inplace_repeat: PySequence_Inplace_Repeat_func
    
    public init(length: PySequence_Length_func = nil, concat: PySequence_Concat_func = nil, repeat_: PySequence_Repeat_func = nil, get_item: PySequence_Item_func = nil, set_item: PySequence_Ass_Item_func = nil, contains: PySequence_Contains_func = nil, inplace_concat: PySequence_Inplace_Concat_func = nil, inplace_repeat: PySequence_Inplace_Repeat_func = nil) {
        self.length = length
        self.concat = concat
        self.repeat_ = repeat_
        self.get_item = get_item
        self.set_item = set_item
        self.contains = contains
        self.inplace_concat = inplace_concat
        self.inplace_repeat = inplace_repeat
    }
}

public class PySequenceMethodsHandler {
    
    public let methods: UnsafeMutablePointer<PySequenceMethods>!
    let methods_container: PySequenceMethodWrap!
    
    public init(methods: PySequenceMethodWrap!) {
        
        if methods != nil  {
            self.methods_container = methods
            self.methods = .allocate(capacity: 1)
            self.methods.initialize(to: .init(sq_length: methods.length, sq_concat: methods.concat, sq_repeat: methods.repeat_, sq_item: methods.get_item, was_sq_slice: nil, sq_ass_item: methods.set_item, was_sq_ass_slice: nil, sq_contains: methods.contains, sq_inplace_concat: methods.inplace_concat, sq_inplace_repeat: methods.inplace_repeat))
        } else {
            self.methods = nil
            self.methods_container = nil
        }
        
    }
    
}



class PyGetSetDefWrap {
    let name: UnsafePointer<CChar>
    let doc_string: UnsafePointer<CChar>!
    let getset: PyGetSetDef
    
    init(name: String, doc: String? = nil, getter: PyGetter) {
        let _name: UnsafePointer<CChar> = .init(makeCString(from: name))
        self.name = _name
        var _doc_string: UnsafePointer<CChar>!
        if let doc = doc {
            _doc_string = .init(makeCString(from: doc))
            
        }
        doc_string = _doc_string
        getset = .init(name: _name, get: getter, set: nil, doc: _doc_string, closure: nil)
    }
    
    init(name: String, doc: String? = nil, getter: PyGetter, setter: PySetter) {
        let _name: UnsafePointer<CChar> = .init(makeCString(from: name))
        self.name = _name
        var _doc_string: UnsafePointer<CChar>!
        if let doc = doc {
            _doc_string = .init(makeCString(from: doc))
            
        }
        doc_string = _doc_string
        getset = .init(name: _name, get: getter, set: setter, doc: _doc_string, closure: nil)
    }
    
    deinit {
        name.deallocate()
        guard doc_string != nil else { return }
        doc_string.deallocate()
    }
}

class PyGetSetDefHandler {
    
    let getsets_ptr: UnsafeMutablePointer<PyGetSetDef>
    var getsets_container: [PyGetSetDefWrap]
    
    init(getsets: [PyGetSetDefWrap]) {
        
        getsets_container = getsets
        let count = getsets.count
        getsets_ptr = .allocate(capacity: count + 1)
        for (i, prop) in getsets.enumerated() {
            getsets_ptr[i] = prop.getset
        }
        getsets_ptr[count] = .init()
    }
    
    init(_ getsets: PyGetSetDefWrap...) {
        
        getsets_container = getsets
        let count = getsets.count
        getsets_ptr = .allocate(capacity: count + 1)
        for (i, prop) in getsets.enumerated() {
            getsets_ptr[i] = prop.getset
        }
        getsets_ptr[count] = .init()
    }
    
    deinit {
        getsets_ptr.deallocate()
    }
}

class PyBufferProcsHandler {
    
    let buffer_ptr: UnsafeMutablePointer<PyBufferProcs>
    
    init(getBuffer: PyBuf_Get, releaseBuffer: PyBuf_Release) {
        
 
//        var pixelBuffer : CVImageBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault, 0, 0, kCVPixelFormatType_32ARGB, .none, &pixelBuffer)
//        let buffer = CVPixelBufferGetBaseAddress(pixelBuffer!)!
//        let size = 0
        
        buffer_ptr = .allocate(capacity: 1)
        
        buffer_ptr.pointee = .init(
            bf_getbuffer: getBuffer,
            bf_releasebuffer: releaseBuffer
        )
//        buffer_ptr.pointee = .init(
//
//
//
//            // same as a function
//            bf_getbuffer: { _self, input_buf, count in
//
////                if let buffer = CVPixelBufferGetBaseAddress(pixelBuffer!) {
////                    var pybuf = Py_buffer()
////                    PyBuffer_FillInfo(&pybuf, nil, buffer, size , 0, PyBUF_WRITE)
////                    pybuf.format = nil // becomes uint8 by default
////
////                    input_buf?.pointee = pybuf
////
////                    return 0
////                }
//                return 1
//
//
//            }, bf_releasebuffer: { s, buf in
//
//            })
    }
    
}

let Whatever_Buffer = PyBufferProcsHandler(
    getBuffer: { s, buf, flags in
    
        return 1
    },
    releaseBuffer: { s, buf in
    
    }
)


struct PyTypeFunctions {
    let tp_init: initproc!
    let tp_new: newfunc!
    let tp_dealloc: destructor!
    let tp_getattr: getattrfunc!
    let tp_setattr: setattrfunc!
    let tp_as_number: UnsafeMutablePointer<PyNumberMethods>!
    let tp_as_sequence: UnsafeMutablePointer<PySequenceMethods>!
    let tp_call: ternaryfunc!
    let tp_str: reprfunc!
    let tp_repr: reprfunc!
    //let tp_as_buffer: PyBufferProcsHandler
    
}

public final class SwiftPyType {
    
    public struct TpFlag: RawRepresentable {
        public init?(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        public var rawValue: UInt
        
        public typealias RawValue = UInt
        
        static func |(lhs: Self, rhs: Self) -> Self {
            .init(rawValue: lhs.rawValue | rhs.rawValue)!
        }
        #if BEEWARE
        static public let DEFAULT = TpFlag(rawValue: UInt(Py_TPFLAGS_DEFAULT))!
        #else
        static public let DEFAULT = TpFlag(rawValue: UInt(Python_TPFLAGS_DEFAULT))!
        #endif
        
        static let BASE = TpFlag(rawValue: Py_TPFLAGS_BASETYPE)!
        static let GC = TpFlag(rawValue: Py_TPFLAGS_HAVE_GC)!
        static let DEFAULT_BASE = DEFAULT | BASE
        static let DEFAULT_BASE_GC = DEFAULT_BASE | GC
    }
    
    let tp_name: UnsafePointer<CChar>!
    let pytype: UnsafeMutablePointer<PyTypeObject>
    
    let methods: PyMethodDefHandler?
    let getsets: PyGetSetDefHandler?
    let funcs: PyTypeFunctions
    let sequence: PySequenceMethodsHandler?
    init(
        name: String, functions: PyTypeFunctions,
        methods: PyMethodDefHandler?,
        getsets: PyGetSetDefHandler?,
        sequence: PySequenceMethodsHandler? = nil,
        module_target: PythonPointer = nil) {
            PyErr_Print()
            print("SwiftPyType:")
            self.tp_name = makeCString(from: name)
            self.methods = methods
            self.getsets = getsets
            self.funcs = functions
            self.sequence = sequence
            
            pytype = .allocate(capacity: 1)
            
            createPyType()
            
            //#if os(OSX)
            //PyModule_AddType(python_handler.python_module, pytype)
            //#endif
    }
    
    init(name: String, functions: PyTypeFunctions, methods: PyMethodDefHandler?, getsets: PyGetSetDefHandler?, module_target: PythonPointer ) {
        self.tp_name = makeCString(from: name)
        self.methods = methods
        self.getsets = getsets
        self.funcs = functions
        self.sequence = nil
        pytype = .allocate(capacity: 1)
        createPyType()
        //#if os(OSX)
        //PyModule_AddType(python_handler.python_module, pytype)
        //#endif
    }
    
    func createPyType(_ flag: TpFlag = .DEFAULT_BASE) {
        var py_type = NewPyType()
        
        py_type.tp_name = tp_name
        py_type.tp_basicsize = MemoryLayout.size(ofValue: _object.self)
        
        if let methods = methods {
            py_type.tp_methods = methods.methods_ptr
        }
        if let getsets = getsets {
            py_type.tp_getset = getsets.getsets_ptr
        }
        
        if let sequence = sequence {
            py_type.tp_as_sequence = sequence.methods
        }
        
        //py_type.tp_members = members
        py_type.tp_flags =  flag.rawValue
        
        py_type.tp_new = funcs.tp_new
        py_type.tp_init = funcs.tp_init
        
        //py_type.tp_vectorcall = nil
//        py_type.tp_vectorcall = {s, a, n, k  in
//            print("tp_vectorcall")
//            pyPrint(s)
//            pyPrint(a![0])
//            
//            return returnPyNone()
//        }
        //py_type.tp_vectorcall_offset = -1
        //py_type.tp_alloc = NewPyObject_Alloc
        py_type.tp_basicsize = PySwiftObject_size
        py_type.tp_dictoffset = PySwiftObject_dict_offset
        py_type.tp_dealloc = funcs.tp_dealloc
        py_type.tp_call = funcs.tp_call
        py_type.tp_getattr = funcs.tp_getattr
        py_type.tp_setattr = funcs.tp_setattr
        
        py_type.tp_getattro = PyObject_GenericGetAttr
        py_type.tp_setattro = PyObject_GenericSetAttr
        
//        py_type.tp_repr = { s in
//            return "name".withCString(PyUnicode_FromString())
//        }
//
//        py_type.tp_str = { s in
//            return "name"
//        }
        

        
        //py_type
//        {s, v in
//            print("getattr", v.printString)
//            return returnPyNone()
//        }
        //print(String(cString: tp_name))
        PyErr_Print()
        pytype.pointee = py_type
        
        
        if PyType_Ready(pytype) < 0 {
            PyErr_Print()
            fatalError("PyReady failed")
        }
        
    }
    
    deinit {
        tp_name.deallocate()
        pytype.deallocate()
    }
}

extension PySwiftObjectPointer {
    
    func releaseSwiftPointer<T: AnyObject>(_ value: T.Type) {
        if let ptr = self?.pointee.swift_ptr {
            Unmanaged<T>.fromOpaque(ptr).release()
        }
    }
    
//    func setSwiftPointer<T: AnyObject>(_ value: T) {
//        self?.pointee.swift_ptr = Unmanaged.passRetained(value).toOpaque()
//    }
}

extension PythonPointer {
    
    var pyswift_cls: PySwiftObject { PySwiftObject_Cast(self).pointee }
    
    
    
    func getSwiftPointer<T: Hashable>() -> T {
        let ptr = PySwiftObject_Cast(self).pointee.swift_ptr!
        return ptr.assumingMemoryBound(to: T.self).pointee
    }
    
//
//    func getSwiftPointer<T: AnyObject>() -> T {
//        return Unmanaged<T>.fromOpaque(
//            PySwiftObject_Cast(self).pointee.swift_ptr
//        ).takeUnretainedValue()
//    }
    
    func setSwiftPointer_cls<T: AnyObject>(_ value: T) {
        PySwiftObject_Cast(self).pointee.swift_ptr = Unmanaged.passUnretained(value).toOpaque()
    }
    
    func setSwiftPointer<T: Hashable>(_ value: T) {
        let ptr: UnsafeMutablePointer<T> = .allocate(capacity: 1)
        ptr.pointee = value
        PySwiftObject_Cast(self).pointee.swift_ptr = .init(ptr)
    }
//
//    func setSwiftPointer<T: AnyObject>(_ value: T) {
//        PySwiftObject_Cast(self).pointee.swift_ptr = Unmanaged.passRetained(value).toOpaque()
//    }
    
    func releaseSwiftPointer<T: AnyObject>(_ value: T.Type) {
        PySwiftObject_Cast(self).releaseSwiftPointer(value)
    }
    
//    func releaseSwiftPointer<T: AnyObject>() {
////        Unmanaged<T>.fromOpaque(
////            PySwiftObject_Cast(self).pointee.swift_ptr
////        )
//    }
}
