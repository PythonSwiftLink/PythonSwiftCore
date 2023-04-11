import Foundation
#if BEEWARE
import PythonLib
#endif

extension Optional: PyConvertible where Wrapped == PyConvertible {
    public var pyObject: PythonObject { .init(getter: pyPointer) }
    
    public var pyPointer: PyPointer { self?.pyPointer ?? .PyNone }
}

extension PythonObject : PyConvertible {
    
    
    public var pyPointer: PyPointer {
        ptr ?? .PyNone
    }
    
    public var pyObject: PythonObject {
        self
    }
    
}

extension PyPointer : PyConvertible {
    
    
    public var pyObject: PythonObject {
        .init(getter: self)
    }
    
    public var pyPointer: PyPointer {
        xINCREF
    }
    
}

//extension UnsafeMutablePointer<_object> : PyConvertible {
//    public var pyObject: PythonObject {
//        .init(getter: self)
//    }
//
//    public var pyPointer: PyPointer {
//        self
//    }
//
//}

extension Data? {
    public var pyPointer: PyPointer {
        self?.pyPointer ?? .PyNone
    }
}

extension Data: PyConvertible {
    public var pyObject: PythonObject {
        .init(getter: nil)
    }
    
    public var pyPointer: PyPointer {
        var this = self
        return this.withUnsafeMutableBytes { buffer -> PyPointer in
            let size = self.count //* uint8_size
            var pybuf = Py_buffer()
            PyBuffer_FillInfo(&pybuf, nil, buffer.baseAddress, size , 0, PyBUF_WRITE)
            let mem = PyMemoryView_FromBuffer(&pybuf)
            let bytes = PyBytes_FromObject(mem)
            Py_DecRef(mem)
            return bytes ?? .PyNone
        }
    }
    
}

extension Bool : PyConvertible {
    
    
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
    
}

//extension String? {
//    public var pyPointer: PyPointer {
//        if let this = self {
//            return this.withCString(PyUnicode_FromString) ?? .PyNone
//        }
//        return .PyNone
//    }
//}

extension String : PyConvertible {
    
    
    public var pyPointer: PyPointer {
        withCString(PyUnicode_FromString) ?? .PyNone
    }
    
    public var pyObject: PythonObject {
        .init(getter: withCString(PyUnicode_FromString) )
    }
    
}


extension URL? {
    public var pyPointer: PyPointer {
        if let this = self {
            return this.pyPointer
        }
        return .PyNone
    }
}

extension URL : PyConvertible {
    public var pyObject: PythonObject {
        .init(getter: path.withCString(PyUnicode_FromString))
    }
    
    public var pyPointer: PyPointer {
        path.withCString(PyUnicode_FromString) ?? .PyNone
    }
    
}

extension Int : PyConvertible {
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(self))
    }

}

extension UInt : PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLong(self))
    }
    
}
extension Int64: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLongLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLongLong(self))
    }
    
}

extension UInt64: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLongLong(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLongLong(self))
    }
    
}

extension Int32: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
}

extension UInt32: PyConvertible {
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
}

extension Int16: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
}

extension UInt16: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLong(UInt(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLong(UInt(self)))
    }
    
}

extension Int8: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromLong(Int(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromLong(Int(self)))
    }
    
}

extension UInt8: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyLong_FromUnsignedLong(UInt(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyLong_FromUnsignedLong(UInt(self)))
    }
    
}

extension Double: PyConvertible {
    
    
    public var pyPointer: PyPointer {
        PyFloat_FromDouble(self)
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyFloat_FromDouble(self))
    }
    
}

extension Float32: PyConvertible {
    
    public var pyPointer: PyPointer {
        PyFloat_FromDouble(Double(self))
    }
    
    public var pyObject: PythonObject {
        .init(getter: PyFloat_FromDouble(Double(self)))
    }
    
}


extension Array: PyConvertible where Element : PyConvertible {

    public var pyPointer: PyPointer {
        let list = PyList_New(count)
        for (index, element) in enumerated() {
            // `PyList_SetItem` steals the reference of the object stored.
            let obj = element.pyPointer
            PyList_SetItem(list, index, obj)
            Py_DecRef(obj)
        }
        return list ?? .PyNone
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
    
    @inlinable public var pythonTuple: PythonPointer {
        let tuple = PyTuple_New(self.count)
        for (i, element) in self.enumerated() {
            PyTuple_SetItem(tuple, i, element.pyPointer)
        }
        return tuple ?? .PyNone
    }
    
}


extension Dictionary: PyConvertible where Key == StringLiteralType, Value == PyConvertible  {
    
    
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
        return dict ?? .PyNone
    }
    
    
}
