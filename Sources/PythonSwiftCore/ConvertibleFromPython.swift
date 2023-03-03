import Foundation
#if BEEWARE
import PythonLib
#endif



extension PythonObject : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        self = .init(getter: object)
    }
    
}

extension PyPointer : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        self = object
    }
    
    
}

extension UnsafeMutablePointer<_object> : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard let o = object else { throw PythonError.attribute }
        self = o
    }
    
}


extension Data: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        self = object.memoryViewAsData() ?? .init()
    }
}

extension Bool : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        if object == PythonTrue {
            self = true
        } else if object == PythonFalse {
            self = false
        } else {
            throw PythonError.attribute
            return
        }
        
    }
}


extension String : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonUnicode_Check(object) else { throw PythonError.unicode }
        self.init(cString: PyUnicode_AsUTF8(object))
    }
    
}


extension URL : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonUnicode_Check(object) else { throw PythonError.unicode }
        let path = String(cString: PyUnicode_AsUTF8(object))
        guard let url = URL(string: path) else { throw URLError(.badURL) }
        self = url
    }
    
}

extension Int : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self = PyLong_AsLong(object)
    }
}

extension UInt : ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self = PyLong_AsUnsignedLong(object)
    }
}
extension Int64: ConvertibleFromPython {
    
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self = PyLong_AsLongLong(object)
    }
}

extension UInt64:ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self = PyLong_AsUnsignedLongLong(object)
    }
}

extension Int32: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self = _PyLong_AsInt(object)
    }
}

extension UInt32: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self.init(PyLong_AsUnsignedLong(object))
    }
}

extension Int16: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self.init(clamping: PyLong_AsLong(object))
    }
    
}

extension UInt16: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self.init(clamping: PyLong_AsUnsignedLong(object))
    }
    
}

extension Int8: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self.init(clamping: PyLong_AsUnsignedLong(object))
    }
    
}

extension UInt8: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonLong_Check(object) else { throw PythonError.long }
        self.init(clamping: PyLong_AsUnsignedLong(object))
    }
}

extension Double: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        if PythonFloat_Check(object){
            self = PyFloat_AsDouble(object)
        } else if PythonLong_Check(object) {
            self = PyLong_AsDouble(object)
        }
        else { throw PythonError.float }
        
    }
}

extension Float32: ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        guard PythonFloat_Check(object) else { throw PythonError.float }
        self.init(PyFloat_AsDouble(object))
    }
}


extension Array : ConvertibleFromPython where Element : PyConvertible & ConvertibleFromPython {
    
    public init(object: PyPointer) throws {
        if PythonList_Check(object) {
            self = try object.getBuffer().map(Element.init)
        } else if PythonTuple_Check(object) {
            self = try object.getBuffer().map(Element.init)
        } else {
            throw PythonError.sequence
        }
    }
    
}
