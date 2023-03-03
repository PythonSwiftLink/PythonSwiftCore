
import Foundation
#if BEEWARE
import PythonLib
#endif



public protocol PyConvertible {
    
    var pyObject: PythonObject { get }
    var pyPointer: PyPointer { get }
}


public protocol ConvertibleFromPython {
    
    init(object: PyPointer) throws
}


public protocol PyBufferProtocol {
    func __buffer__(s: PyPointer, buffer: UnsafeMutablePointer<Py_buffer>) -> Int32
}
public protocol PyBufferStructProtocol {
    mutating func __buffer__(s: PyPointer, buffer: UnsafeMutablePointer<Py_buffer>) -> Int32
}


public protocol PySequenceProtocol {
    
}

public protocol PyMappingProtocol {
    
}

public protocol PyNumericProtocol {
    
}
