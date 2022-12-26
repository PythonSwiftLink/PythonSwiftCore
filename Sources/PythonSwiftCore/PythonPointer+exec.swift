//
//  File.swift
//  
//
//  Created by MusicMaker on 10/10/2022.
//

import Foundation
#if BEEWARE
import PythonLib
#endif

public enum PyEvalFlag: Int32 {
    case single = 256
    case file = 257
    case eval = 258
    case func_type = 345
    case fstring = 800
    
    
    
}
#if BEEWARE
public func Py_CompileString(code: String,  filename: String, flag: PyEvalFlag) -> PyPointer {
    code.withCString { str in
        Py_CompileString(str, filename, flag.rawValue)
    }
}
#endif

public func PyRun_String(string: String, flag: PyEvalFlag, globals: PyPointer, locals: PyPointer) -> PyPointer {
    string.withCString { str in
        PyRun_String(str, flag.rawValue, globals, locals)
    }
}
