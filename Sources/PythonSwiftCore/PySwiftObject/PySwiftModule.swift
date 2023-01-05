//
//  File.swift
//  
//
//  Created by MusicMaker on 21/12/2022.
//

import Foundation
#if BEEWARE
import PythonLib
#endif


//fileprivate var py_mod = PyModuleDef(
//    m_base: PythonModuleDef_HEAD_INIT,
//    m_name: "",
//    m_doc: nil,
//    m_size: -1,
//    m_methods: nil,
//    m_slots: nil,
//    m_traverse: nil,
//    m_clear: nil,
//    m_free: nil
//)

public class PyModuleDefHandler {
    
    let name: UnsafePointer<CChar>
    
    let module: UnsafeMutablePointer<PyModuleDef>!
    
    private let methods: PyMethodDefHandler?
    
    init(name: String, methods: PyMethodDefHandler?) {
        self.name = makeCString(from: name)
        self.methods = methods
        module = .allocate(capacity: 1)
        module.pointee = PyModuleDef(
            m_base: PythonModuleDef_HEAD_INIT,
            m_name: self.name,
            m_doc: nil,
            m_size: -1,
            m_methods: self.methods?.methods_ptr,
            m_slots: nil,
            m_traverse: nil,
            m_clear: nil,
            m_free: nil
        )
        
    }
    
}


fileprivate let fib_module = PyModuleDefHandler(
    name: "fib",
    methods: nil
)
fileprivate let py_module = fib_module.module

func PyInitFib() -> PythonPointer {
    
    if let m = Py_Module_Create(py_module) {
        
        //PyModule_AddObject(m, "fib", "")
        //PyModule_AddType(m, <#T##type: UnsafeMutablePointer<PyTypeObject>!##UnsafeMutablePointer<PyTypeObject>!#>)
        
        return m
    }
    return nil
}
