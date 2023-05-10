
#if BEEWARE
import PythonLib
#endif

import Foundation
extension PyPointer {

    func callAsFunction<R>() throws -> R where 
    	R: ConvertibleFromPython {
        guard let result = PyObject_CallNoArgs(self) else {
            PyErr_Print()
            throw PythonError.call
        }
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction() throws -> PyPointer {
        guard let result = PyObject_CallNoArgs(self) else {
            PyErr_Print()
            throw PythonError.call
        }
        return result
    }

    func callAsFunction() throws {
        guard let result = PyObject_CallNoArgs(self) else {
            PyErr_Print()
            throw PythonError.call
        }
        Py_DecRef(result)
    }

    func callAsFunction<A, R>(_ a: A) throws -> R where 
    	A: PyConvertible, 
    	R: ConvertibleFromPython {
        let arg = a.pyPointer
        guard let result = PyObject_CallOneArg(self, arg) else {
            PyErr_Print()
            Py_DecRef(arg)
            throw PythonError.call
        }
        Py_DecRef(arg)
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A>(_ a: A) throws -> PyPointer where 
    	A: PyConvertible {
        let arg = a.pyPointer
        guard let result = PyObject_CallOneArg(self, arg) else {
            PyErr_Print()
            Py_DecRef(arg)
            throw PythonError.call
        }
        Py_DecRef(arg)
        return result
    }

    func callAsFunction<A>(_ a: A) throws where 
    	A: PyConvertible {
        let arg = a.pyPointer
        guard let result = PyObject_CallOneArg(self, arg) else {
            PyErr_Print()
            Py_DecRef(arg)
            throw PythonError.call
        }
        Py_DecRef(arg)
        Py_DecRef(result)
    }

    func callAsFunction<A, B, R>(_ a: A, _ b: B) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 2)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 2, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B>(_ a: A, _ b: B) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 2)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 2, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B>(_ a: A, _ b: B) throws where 
    	A: PyConvertible, 
    	B: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 2)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 2, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, R>(_ a: A, _ b: B, _ c: C) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 3)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 3, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C>(_ a: A, _ b: B, _ c: C) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 3)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 3, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C>(_ a: A, _ b: B, _ c: C) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 3)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 3, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, D, R>(_ a: A, _ b: B, _ c: C, _ d: D) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 4)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 4, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 4)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 4, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 4)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 4, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, D, E, R>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 5)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 5, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 5)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 5, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 5)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 5, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, D, E, F, R>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 6)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 6, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 6)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 6, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 6)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 6, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, D, E, F, G, R>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 7)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 7, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C, D, E, F, G>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 7)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 7, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C, D, E, F, G>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 7)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 7, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, D, E, F, G, H, R>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	H: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 8)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        args[7] = h.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 8, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            Py_DecRef(args[7])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C, D, E, F, G, H>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	H: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 8)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        args[7] = h.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 8, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            Py_DecRef(args[7])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C, D, E, F, G, H>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	H: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 8)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        args[7] = h.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 8, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            Py_DecRef(args[7])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        args.deallocate()
        Py_DecRef(result)
    }

    func callAsFunction<A, B, C, D, E, F, G, H, I, R>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) throws -> R where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	H: PyConvertible, 
    	I: PyConvertible, 
    	R: ConvertibleFromPython {
        let args = VectorCallArgs.allocate(capacity: 9)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        args[7] = h.pyPointer
        args[8] = i.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 9, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            Py_DecRef(args[7])
            Py_DecRef(args[8])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        Py_DecRef(args[8])
        args.deallocate()
        let rtn = try R(object: result)
        Py_DecRef(result)
        return rtn
    }

    func callAsFunction<A, B, C, D, E, F, G, H, I>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) throws -> PyPointer where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	H: PyConvertible, 
    	I: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 9)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        args[7] = h.pyPointer
        args[8] = i.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 9, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            Py_DecRef(args[7])
            Py_DecRef(args[8])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        Py_DecRef(args[8])
        args.deallocate()
        return result
    }

    func callAsFunction<A, B, C, D, E, F, G, H, I>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) throws where 
    	A: PyConvertible, 
    	B: PyConvertible, 
    	C: PyConvertible, 
    	D: PyConvertible, 
    	E: PyConvertible, 
    	F: PyConvertible, 
    	G: PyConvertible, 
    	H: PyConvertible, 
    	I: PyConvertible {
        let args = VectorCallArgs.allocate(capacity: 9)
        args[0] = a.pyPointer
        args[1] = b.pyPointer
        args[2] = c.pyPointer
        args[3] = d.pyPointer
        args[4] = e.pyPointer
        args[5] = f.pyPointer
        args[6] = g.pyPointer
        args[7] = h.pyPointer
        args[8] = i.pyPointer
        guard let result = PyObject_Vectorcall(self, args, 9, nil) else {
            PyErr_Print()
            Py_DecRef(args[0])
            Py_DecRef(args[1])
            Py_DecRef(args[2])
            Py_DecRef(args[3])
            Py_DecRef(args[4])
            Py_DecRef(args[5])
            Py_DecRef(args[6])
            Py_DecRef(args[7])
            Py_DecRef(args[8])
            args.deallocate()
            throw PythonError.call
        }
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        Py_DecRef(args[8])
        args.deallocate()
        Py_DecRef(result)
    }
}


func PythonCall < R>(call: PyPointer) throws -> R where 
	R: ConvertibleFromPython {
    guard let result = PyObject_CallNoArgs(call) else {
        PyErr_Print()
        throw PythonError.call
    }
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall(call: PyPointer) throws -> PyPointer {
    guard let result = PyObject_CallNoArgs(call) else {
        PyErr_Print()
        throw PythonError.call
    }
    return result
}

func PythonCall(call: PyPointer) throws {
    guard let result = PyObject_CallNoArgs(call) else {
        PyErr_Print()
        throw PythonError.call
    }
    Py_DecRef(result)
}

func PythonCall<A, R>(call: PyPointer, _ a: A) throws -> R where 
	A: PyConvertible, 
	R: ConvertibleFromPython {
    let arg = a.pyPointer
    guard let result = PyObject_CallOneArg(call, arg) else {
        PyErr_Print()
        Py_DecRef(arg)
        throw PythonError.call
    }
    Py_DecRef(arg)
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A>(call: PyPointer, _ a: A) throws -> PyPointer where 
	A: PyConvertible {
    let arg = a.pyPointer
    guard let result = PyObject_CallOneArg(call, arg) else {
        PyErr_Print()
        Py_DecRef(arg)
        throw PythonError.call
    }
    Py_DecRef(arg)
    return result
}

func PythonCall<A>(call: PyPointer, _ a: A) throws where 
	A: PyConvertible {
    let arg = a.pyPointer
    guard let result = PyObject_CallOneArg(call, arg) else {
        PyErr_Print()
        Py_DecRef(arg)
        throw PythonError.call
    }
    Py_DecRef(arg)
    Py_DecRef(result)
}

func PythonCall<A, B, R>(call: PyPointer, _ a: A, _ b: B) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 2)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 2, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B>(call: PyPointer, _ a: A, _ b: B) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 2)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 2, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    args.deallocate()
    return result
}

func PythonCall<A, B>(call: PyPointer, _ a: A, _ b: B) throws where 
	A: PyConvertible, 
	B: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 2)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 2, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, R>(call: PyPointer, _ a: A, _ b: B, _ c: C) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 3)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 3, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C>(call: PyPointer, _ a: A, _ b: B, _ c: C) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 3)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 3, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    args.deallocate()
    return result
}

func PythonCall<A, B, C>(call: PyPointer, _ a: A, _ b: B, _ c: C) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 3)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 3, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, D, R>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 4)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 4, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C, D>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 4)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 4, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    args.deallocate()
    return result
}

func PythonCall<A, B, C, D>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 4)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 4, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, D, E, R>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 5)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 5, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C, D, E>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 5)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 5, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    args.deallocate()
    return result
}

func PythonCall<A, B, C, D, E>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 5)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 5, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, D, E, F, R>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 6)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 6, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C, D, E, F>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 6)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 6, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    args.deallocate()
    return result
}

func PythonCall<A, B, C, D, E, F>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 6)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 6, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, D, E, F, G, R>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 7)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 7, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C, D, E, F, G>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 7)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 7, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    args.deallocate()
    return result
}

func PythonCall<A, B, C, D, E, F, G>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 7)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 7, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, D, E, F, G, H, R>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	H: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 8)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    args[7] = h.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 8, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    Py_DecRef(args[7])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C, D, E, F, G, H>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	H: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 8)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    args[7] = h.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 8, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    Py_DecRef(args[7])
    args.deallocate()
    return result
}

func PythonCall<A, B, C, D, E, F, G, H>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	H: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 8)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    args[7] = h.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 8, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    Py_DecRef(args[7])
    args.deallocate()
    Py_DecRef(result)
}

func PythonCall<A, B, C, D, E, F, G, H, I, R>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) throws -> R where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	H: PyConvertible, 
	I: PyConvertible, 
	R: ConvertibleFromPython {
    let args = VectorCallArgs.allocate(capacity: 9)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    args[7] = h.pyPointer
    args[8] = i.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 9, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        Py_DecRef(args[8])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    Py_DecRef(args[7])
    Py_DecRef(args[8])
    args.deallocate()
    let rtn = try R(object: result)
    Py_DecRef(result)
    return rtn
}

func PythonCall<A, B, C, D, E, F, G, H, I>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) throws -> PyPointer where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	H: PyConvertible, 
	I: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 9)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    args[7] = h.pyPointer
    args[8] = i.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 9, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        Py_DecRef(args[8])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    Py_DecRef(args[7])
    Py_DecRef(args[8])
    args.deallocate()
    return result
}

func PythonCall<A, B, C, D, E, F, G, H, I>(call: PyPointer, _ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) throws where 
	A: PyConvertible, 
	B: PyConvertible, 
	C: PyConvertible, 
	D: PyConvertible, 
	E: PyConvertible, 
	F: PyConvertible, 
	G: PyConvertible, 
	H: PyConvertible, 
	I: PyConvertible {
    let args = VectorCallArgs.allocate(capacity: 9)
    args[0] = a.pyPointer
    args[1] = b.pyPointer
    args[2] = c.pyPointer
    args[3] = d.pyPointer
    args[4] = e.pyPointer
    args[5] = f.pyPointer
    args[6] = g.pyPointer
    args[7] = h.pyPointer
    args[8] = i.pyPointer
    guard let result = PyObject_Vectorcall(call, args, 9, nil) else {
        PyErr_Print()
        Py_DecRef(args[0])
        Py_DecRef(args[1])
        Py_DecRef(args[2])
        Py_DecRef(args[3])
        Py_DecRef(args[4])
        Py_DecRef(args[5])
        Py_DecRef(args[6])
        Py_DecRef(args[7])
        Py_DecRef(args[8])
        args.deallocate()
        throw PythonError.call
    }
    Py_DecRef(args[0])
    Py_DecRef(args[1])
    Py_DecRef(args[2])
    Py_DecRef(args[3])
    Py_DecRef(args[4])
    Py_DecRef(args[5])
    Py_DecRef(args[6])
    Py_DecRef(args[7])
    Py_DecRef(args[8])
    args.deallocate()
    Py_DecRef(result)
}