//
//  File.swift
//  
//
//  Created by MusicMaker on 12/10/2022.
//

import Foundation

#if BEEWARE
import PythonLib
#endif

//public func PyErr_Printer() -> (type: PyPointer, value: PyPointer, tb: PyPointer) {
//    var type: PyPointer = nil
//    var value: PyPointer = nil
//    var tb: PyPointer = nil
//    PyErr_Fetch(&type, &value, &tb)
//    return (type,value,tb)
//}

public func PyErr_Printer(_ com: @escaping (_ type: PyPointer,_ value: PyPointer,_ tb: PyPointer) -> () ) {
    var type: PyPointer = nil
    var value: PyPointer = nil
    var tb: PyPointer = nil
    PyErr_Fetch(&type, &value, &tb)
    com(type,value,tb)
    if type != nil { type.decref() }
    if value != nil { value.decref() }
    if tb != nil { tb.decref() }
    //PyErr_Restore(type, value, tb)
    //PyErr_Clear()
}

/**
    Repeats a string `times` times.

    - Parameter str:   The string to repeat.
    - Parameter times: The number of times to repeat `str`.

    - Throws: `MyError.InvalidTimes` if the `times` parameter
      is less than zero.

    - Returns: A new string with `str` repeated `times` times.
*/

public struct PyScriptError {
    public let except_text: String
    public let line_no: Int
    public let start: Int
    public let end: Int
    public let line_text: String
}

public func PyErr_Printer() -> PyScriptError {
    var except_string = ""
    var line_no = 0
    var start = 0
    var end = 0
    var text = ""
    
    PyErr_Printer { type, value, tb in
        except_string = PyTuple_GetItem(value, 0).string ?? ""
        let line_tuple = PyTuple_GetItem(value, 1)

        line_no = PyTuple_GetItem(line_tuple, 1).int
        start = PyTuple_GetItem(line_tuple, 2).int
        text = PyTuple_GetItem(line_tuple, 3).string ?? ""
        end = PyTuple_GetItem(line_tuple, 5).int
        
    }
    //print(except_string)
    text.removeFirst()
    print(line_no,start,end,text)
    
    return .init(except_text: except_string, line_no: line_no, start: start, end: end, line_text: text)
    
}

