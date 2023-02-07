
import Foundation
#if BEEWARE
import PythonLib
#endif

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
