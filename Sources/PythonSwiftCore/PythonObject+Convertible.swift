

import Foundation
import PythonLib


public protocol PyConvertible {
    /// A `PythonObject` instance representing this value.
    var pyObject: PythonObject { get }
    var pyPointer: PyPointer { get }
}


public protocol ConvertibleFromPython {
    /// Creates a new instance from the given `PythonObject`, if possible.
    /// - Note: Conversion may fail if the given `PythonObject` instance is
    ///   incompatible (e.g. a Python `string` object cannot be converted into an
    ///   `Int`).
    init(_ object: PythonObject)
    init(_ ptr: PyPointer)
}



extension PythonObject : PyConvertible, ConvertibleFromPython {
    public init(_ ptr: PyPointer) {
        self.init(getter: ptr)
    }
    
    public var pyPointer: PyPointer {
        ptr
    }
    
    public var pyObject: PythonObject {
        self
    }

    
    public init(_ object: PythonObject) {
        self = object
    }
    

}

extension PyPointer : PyConvertible, ConvertibleFromPython {
    
    
    public var pyObject: PythonObject {
        .init(getter: self)
    }
    
    public var pyPointer: PyPointer {
        self
    }
    
    public init(_ object: PythonObject) {
        self = object.ptr
    }
    
    public init(_ ptr: PyPointer) {
        self = ptr
    }
    
}

extension UnsafeMutablePointer<_object> : PyConvertible, ConvertibleFromPython {
    public var pyObject: PythonObject {
        .init(getter: self)
    }
    
    public var pyPointer: PyPointer {
        self
    }
    
    public init(_ object: PythonObject) {
        if let ptr = object.ptr {
            self = ptr
        } else {
            self = PyPointer.PyNone!
        }
    }
    
    public init(_ ptr: PyPointer) {
        self = ptr!
    }
    
}

extension Bool : PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        if self {
            return .True
        }
        return .False
    }
    
    public var pyObject: PythonObject {
        if self {
            return .init(getter: .True)
        }
        return .init(getter: .False)
    }
    
    public init(_ object: PythonObject) {
        if object.ptr == .True {
            self = true
        } else {
            self = false
        }
    }
    public init(_ ptr: PyPointer) {
        if ptr == .True {
            self = true
        } else {
            self = false
        }
    }
}


extension String : PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        withCString(PyUnicode_FromString)
    }
    
    public var pyObject: PythonObject {
        .init(getter: withCString(PyUnicode_FromString) )
    }
    
    public init(_ object: PythonObject) {
        self.init(cString: PyUnicode_AsUTF8(object.ptr))
    }
    
    public init(_ ptr: PyPointer) {
        self.init(cString: PyUnicode_AsUTF8(ptr))
    }
}

extension URL : PyConvertible, ConvertibleFromPython {
    public var pyObject: PythonObject {
        .init(getter: path.withCString(PyUnicode_FromString))
    }
    
    public var pyPointer: PyPointer {
        path.withCString(PyUnicode_FromString)
    }
    
    public init(_ object: PythonObject) {
        self.init(string: .init(object))!
    }
    
    public init(_ ptr: PyPointer) {
        self.init(string: .init(ptr))!
    }
    
    
}

extension Int : PyConvertible, ConvertibleFromPython {
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(self))
    }
    
    public init(_ object: PythonObject) {
        self = PyLong_AsLong(object.ptr)
    }
    
    public init(_ ptr: PyPointer) {
        self = PyLong_AsLong(ptr)
    }
}

extension UInt : PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLong(self))
    }
    
    public init(_ object: PythonObject) {
        self = PyLong_AsUnsignedLong(object.ptr)
    }
    public init(_ ptr: PyPointer) {
        self = PyLong_AsUnsignedLong(ptr)
    }
}
extension Int64: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLongLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLongLong(self))
    }
    
    public init(_ object: PythonObject) {
        self = PyLong_AsLongLong(object.ptr)
    }
    
    public init(_ ptr: PyPointer) {
        self = PyLong_AsLongLong(ptr)
    }
}

extension UInt64: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLongLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLongLong(self))
    }
    
    public init(_ object: PythonObject) {
        self.init(PyLong_AsUnsignedLongLong(object.ptr))
    }
    
    public init(_ ptr: PyPointer) {
        self.init(PyLong_AsUnsignedLongLong(ptr))
    }
}

extension Int32: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
    public init(_ object: PythonObject) {
        self = _PyLong_AsInt(object.ptr)
    }
    
    public init(_ ptr: PyPointer) {
        self = _PyLong_AsInt(ptr)
    }
}

extension UInt32: PyConvertible, ConvertibleFromPython {
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
    public init(_ object: PythonObject) {
        self.init(PyLong_AsUnsignedLong(object.ptr))
    }
    
    public init(_ ptr: PyPointer) {
        self.init(PyLong_AsUnsignedLong(ptr))
    }
}

extension Int16: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
    public init(_ object: PythonObject) {
        self.init(clamping: PyLong_AsLong(object.ptr))
    }
    
    public init(_ ptr: PyPointer) {
        self.init(clamping: PyLong_AsLong(ptr))
    }
    
}

extension UInt16: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLong(UInt(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLong(UInt(self)))
    }
    
    public init(_ object: PythonObject) {
        self.init(clamping: PyLong_AsUnsignedLong(object.ptr))
    }
    public init(_ ptr: PyPointer) {
        self.init(clamping: PyLong_AsUnsignedLong(ptr))
    }
    
}

extension Int8: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
    public init(_ object: PythonObject) {
        self.init(clamping: PyLong_AsLong(object.ptr))
    }
    
    public init(_ ptr: PyPointer) {
        self.init(clamping: PyLong_AsLong(ptr))
    }
    
}

extension UInt8: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLong(UInt(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLong(UInt(self)))
    }
    
    public init(_ object: PythonObject) {
        self.init(clamping: PyLong_AsUnsignedLong(object.ptr))
    }
    public init(_ ptr: PyPointer) {
        self.init(clamping: PyLong_AsUnsignedLong(ptr))
    }
}

extension Double: PyConvertible, ConvertibleFromPython {
    
    
    public var pyPointer: PyPointer {
        PyFloat_FromDouble(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyFloat_FromDouble(self))
    }
    
    public init(_ object: PythonObject) {
        self = PyFloat_AsDouble(object.ptr)
    }
    
    public init(_ ptr: PyPointer) {
        self = PyFloat_AsDouble(ptr)
    }
}

extension Float32: PyConvertible, ConvertibleFromPython {
    
    public var pyPointer: PyPointer {
        PyFloat_FromDouble(Double(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyFloat_FromDouble(Double(self)))
    }
    
    public init(_ object: PythonObject) {
        self.init(PyFloat_AsDouble(object.ptr))
    }
    
    public init(_ ptr: PyPointer) {
        self.init(PyFloat_AsDouble(ptr))
    }
}




extension Array : PyConvertible where Element : PyConvertible {
    public var pyPointer: PyPointer {
        let list = PyList_New(count)
        for (index, element) in enumerated() {
            // `PyList_SetItem` steals the reference of the object stored.
            let obj = element.pyPointer
            PyList_SetItem(list, index, obj)
            Py_DecRef(obj)
        }
        return list
    }
    
    public var pyObject: PythonObject {
        let list = PyList_New(count)
        for (index, element) in enumerated() {
            // `PyList_SetItem` steals the reference of the object stored.
            let obj = element.pyPointer
            PyList_SetItem(list, index, element.pyPointer)
            Py_DecRef(obj)
        }
        return .init(getter: list)
    }

}

extension Dictionary<String,PyConvertible>: PyConvertible  {

    
    public var pyObject: PythonObject {
        .init(getter: pyPointer)
    }
    
    public var pyPointer: PyPointer {
        let dict = PyDict_New()
        for (key,value) in self {
            let v = value.pyPointer
            _ = key.withCString{PyDict_SetItemString(dict, $0, v)}
            Py_DecRef(v)
        }
        return dict
    }
    
    
}
