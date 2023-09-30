import Foundation
import PythonLib
import PythonTypeAlias



public func PyDict_GetItem(_ dict: PyPointer, _ key: String) -> PyPointer {
    key.withCString { PyDict_GetItemString(dict, $0) }
}

public func PyDict_GetItem<R: ConvertibleFromPython>(_ dict: PyPointer, _ key: String) throws -> R {
    try key.withCString {
        guard let ptr = PyDict_GetItemString(dict, $0) else { throw PythonError.attribute }
        defer { Py_DecRef(ptr) }
        return try R(object: ptr) }
}
public func PyDict_GetItem<R: ConvertibleFromPython>(_ dict: PyPointer?, _ key: String) throws -> R {
    try key.withCString {
        guard
            let dict = dict,
            let ptr = PyDict_GetItemString(dict, $0)
        else { throw PythonError.attribute }
        defer { Py_DecRef(ptr) }
        return try R(object: ptr) }
}

public func PyDict_PopItem(_ dict: PyPointer, _ key: String) -> PyPointer? {
    key.withCString {
        let item = PyDict_GetItemString(dict, $0)
        _ = PyDict_DelItemString(dict, $0)
        return item
    }
}

@discardableResult
public func PyDict_ReplaceItemKey(_ dict: PyPointer, key: String, new: String) -> Int32 {
    key.withCString {
        let item = PyDict_GetItemString(dict, $0)
        _ = PyDict_DelItemString(dict, $0)
        return new.withCString { PyDict_SetItemString(dict, $0, item) }
    }
}


@discardableResult
public func PyDict_DelItem(_ dict: PyPointer, _ key: String) -> Int32 {
    key.withCString { PyDict_DelItemString(dict, $0) }
}



@discardableResult
public func PyDict_SetItem(_ dict: PyPointer?, _ key: String, _ value: PyPointer) -> Int32 {
    key.withCString { PyDict_SetItemString(dict, $0, value) }
}

public func PyDict_SetItem_Reduced(_ dict: PyPointer,_ next:  Dictionary<String, PyPointer>.Element) -> PyPointer {
    _ = next.key.withCString { PyDict_SetItemString(dict, $0, next.value) }
    return dict
}
public func PyDict_SetItem_ReducedIncRef(_ dict: PyPointer,_ next:  Dictionary<String, PyPointer>.Element) -> PyPointer {
    _ = next.key.withCString { PyDict_SetItemString(dict, $0, next.value.xINCREF) }
    return dict
}

@discardableResult
public func PyDict_SetItem(_ dict: PyPointer?, _ key: String, _ value: PyEncodable) -> Int32 {
    key.withCString { PyDict_SetItemString(dict, $0, value.pyPointer) }
}

extension PyPointer {
    @discardableResult
    public func setPyDictItem(_ key: String, _ value: PyPointer?) -> Int32 {
        key.withCString { PyDict_SetItemString(self, $0, value) }
    }
    
    public func getPyDictItem(_ key: String) -> PyPointer? {
        key.withCString { PyDict_GetItemString(self, $0) }
    }
    
    @discardableResult
    public func replacePyDictKey(_ key: String, new: String) -> Int32 {
        key.withCString {
            let item = PyDict_GetItemString(self, $0)
            _ = PyDict_DelItemString(self, $0)
            return new.withCString { PyDict_SetItemString(self, $0, item) }
        }
    }
    
//    subscript(index: String) -> PyPointer {
//        get {
//            index.withCString { PyDict_GetItemString(self, $0) }
//        }
//        set(newValue) {
//            _ = index.withCString { PyDict_SetItemString(self, $0, newValue) }
//        }
//    }
    
    subscript<T: ConvertibleFromPython & PyConvertible>(index: String) -> T? {
        get {
            index.withCString { try? T(object: PyDict_GetItemString(self, $0) ) }
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            _ = index.withCString { PyDict_SetItemString(self, $0, newValue.pyPointer) }
        }
    }
    
//    subscript<T: ConvertibleFromPython & PyConvertible>(index: String) -> T where T == PyPointer {
//        get {
//            index.withCString { PyDict_GetItemString(self, $0) }
//        }
//        set(newValue) {
//            _ = index.withCString { PyDict_SetItemString(self, $0, newValue) }
//        }
//    }
    
    subscript(index: String) -> String {
        get {
            index.withCString { (try? String(object: PyDict_GetItemString(self, $0) )) ?? "<Null>" }
        }
        set(newValue) {
            let item = newValue.withCString(PyUnicode_FromString)
            _ = index.withCString { PyDict_SetItemString(self, $0, item) }
        }
    }
}


extension PythonObject {
    
    @discardableResult
    public func replacePyDictKey(_ key: String, new: String) -> Int32 {
        key.withCString {
            let item = PyDict_GetItemString(ptr, $0)
            _ = PyDict_DelItemString(ptr, $0)
            return new.withCString { PyDict_SetItemString(ptr, $0, item) }
        }
    }
    
    subscript(index: String) -> PyPointer {
        get {
            index.withCString { PyDict_GetItemString(ptr, $0) }
        }
        set(newValue) {
            _ = index.withCString { PyDict_SetItemString(ptr, $0, newValue) }
        }
    }
    
    subscript(index: String) -> String {
        get {
            index.withCString { (try? String(object: PyDict_GetItemString(ptr, $0) )) ?? "<Null>" }
        }
        set(newValue) {
            let item = newValue.withCString(PyUnicode_FromString)
            _ = index.withCString { PyDict_SetItemString(ptr, $0, item) }
        }
    }
}
