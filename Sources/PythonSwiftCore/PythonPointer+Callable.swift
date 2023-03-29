

import Foundation
#if BEEWARE
import PythonLib
#endif



extension Optional where Wrapped == PythonPointerU {
    
    
    
    @discardableResult
    @inlinable public func callAsFunction(method name: PythonPointer) -> PythonPointer {
        PyObject_CallMethodNoArgs(self, name)
    }
    
    @inlinable public func callAsFunction(method name: String) {
        let name = name.pyStringUTF8
        PyObject_CallMethodNoArgs(self, name)
        Py_DecRef(name)
    }
    
    @inlinable public func callAsFunction(method name: String) -> PythonPointer {
        name.withCString { string in
            let key = PyUnicode_FromString(string)
            let rtn = PyObject_CallMethodNoArgs(self, key)
            Py_DecRef(key)
            return rtn
        }
        //        let name = name.pyStringUTF8
        //        let rtn = PyObject_CallMethodNoArgs(self, name)
        //        Py_DecRef(name)
        //        return rtn
    }
    
    //    @inlinable
    //    func callAsFunction(method name: PythonPointer ,args: [PythonPointer]) -> Void {
    //        //PyObject_Vectorcall(self, args, arg_count, nil)
    //        var _args = [self]
    //        _args.append(contentsOf: args)
    //        PyObject_VectorcallMethod(name, _args , _args.count, nil)
    //    }
    
    @inlinable public func callAsFunction(method name: String ,args: [PythonPointer]) {
        //PyObject_Vectorcall(self, args, arg_count, nil)
        var _args = [self]
        let py_name = name.pyStringUTF8
        _args.append(contentsOf: args)
        PyObject_VectorcallMethod(py_name, _args , _args.count, nil)
        py_name.decref()
        
    }
    
    @discardableResult
    @inlinable public func callAsFunction(method name: PythonPointer ,args: [PythonPointer]) -> PythonPointer {
        //PyObject_Vectorcall(self, args, arg_count, nil)
        var _args = [self]
        _args.append(contentsOf: args)
        return PyObject_VectorcallMethod(name, _args , _args.count, nil)
    }
    
    @inlinable public func callAsFunction(method name: String ,_ arg: PyConvertible) -> PyConvertible {
        //PyObject_Vectorcall(self, args, arg_count, nil)
        let py_name = name.pyPointer
        let v = arg.pyPointer
        let rtn = PyObject_CallMethodOneArg(self, py_name, v)
        py_name.decref()
        v.decref()
        return rtn
    }
    
    @inlinable public func callAsFunction(method name: String ,args: [PythonPointer]) -> PythonPointer {
        //PyObject_Vectorcall(self, args, arg_count, nil)
        var _args = [self]
        let py_name = name.pyStringUTF8
        _args.append(contentsOf: args)
        let rtn = PyObject_VectorcallMethod(py_name, _args , _args.count, nil)
        py_name.decref()
        return rtn
    }
    
    @inlinable public func callAsFunction(method name: String ,_ args: [PyConvertible]) -> PyConvertible {
        //PyObject_Vectorcall(self, args, arg_count, nil)
        var _args = [self]
        let py_name = name.pyPointer
        for a in args {
            let v = a.pyPointer
            _args.append(v)
        }
        let rtn = PyObject_VectorcallMethod(py_name, _args , _args.count, nil)
        for a in _args {
            if a != self {
                Py_DecRef(a)
            }
        }
        py_name.decref()
        return rtn
    }
    
    @inlinable public func callAsFunction(_ args: [PythonPointer], arg_count: Int) {
        PyObject_Vectorcall(self, args, arg_count, nil)
    }
    
    @discardableResult
    @inlinable public func callAsFunction() -> PythonPointer {
        PyObject_CallNoArgs(self)
    }
    
    @discardableResult
    @inlinable public func callAsFunction() -> PyConvertible {
        PyObject_CallNoArgs(self)
    }
    
    @discardableResult
    @inlinable public func callAsFunction(_ arg: PythonPointer) -> PythonPointer {
        PyObject_CallOneArg(self, arg)
    }
    
    
    @inlinable public func callAsFunction<R: ConvertibleFromPython>() throws -> R {
        guard let result = PyObject_CallNoArgs(self) else { throw PythonError.call }
        defer { Py_DecRef(result) }
        return try R(object: result)
    }
//    @discardableResult
    @inlinable public func callAsFunction<R: ConvertibleFromPython>(_ arg: PyConvertible) throws -> R {
        guard let result = PyObject_CallOneArg(self, arg.pyPointer) else { throw PythonError.call }
        defer { Py_DecRef(result) }
        return try R(object: result)
    }
    
//    @discardableResult
    @inlinable public func callAsFunction<R: ConvertibleFromPython>(_ args: PyConvertible...) throws -> R {
        guard let result = PyObject_Vectorcall(self, args.map(\.pyPointer), args.count, nil) else { throw PythonError.call }
        defer { Py_DecRef(result) }
        return try R(object: result )
    }
    
//    @inlinable public func callAsFunction<R: ConvertibleFromPython>(_ args: [PyConvertible]) throws -> R {
//        guard let result = PyObject_Vectorcall(self, args.map(\.pyPointer), args.count, nil) else { throw PythonError.call }
//        defer { Py_DecRef(result) }
//        return try R(object: result )
//    }
    
    //    @inlinable public func callAsFunction() -> Void {
    //        PyObject_CallNoArgs(self)
    //    }
    //
    //    @inlinable public func callAsFunction(_ arg: PythonPointer) -> Void {
    //        PyObject_CallOneArg(self, arg)
    //    }
    
    
    @inlinable public func callAsFunction(_ args: PyPointer...) -> PyPointer {
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable public func callAsFunction(_ args: [PythonPointer]) -> PyPointer {
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable public func callAsFunction(_ args: [PythonPointer], arg_names: PythonPointer){
        PyObject_Vectorcall(self, args, args.count, arg_names)
    }
    
    @inlinable public func callAsFunction(_ args: PythonPointer..., arg_names: PythonPointer){
        PyObject_Vectorcall(self, args, args.count, nil)
    }
    
    @inlinable public func withCall(_ code: @escaping ()->[PythonPointer] ) -> PythonPointer {
        let args = code()
        return PyObject_Vectorcall(self, args, args.count, nil)
    }
    
}
