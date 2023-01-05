

import Foundation
#if BEEWARE
import PythonLib
#endif

public class PyBufferProcsHandler {
    
    let buffer_ptr: UnsafeMutablePointer<PyBufferProcs>
    
    init(getBuffer: PyBuf_Get, releaseBuffer: PyBuf_Release) {
        
        buffer_ptr = .allocate(capacity: 1)
        
        buffer_ptr.pointee = .init(
            bf_getbuffer: getBuffer,
            bf_releasebuffer: releaseBuffer
        )
        
    }
    
    init(getBuffer: PySwiftBuf_Get, releaseBuffer: PySwiftBuf_Release) {
        
        buffer_ptr = .allocate(capacity: 1)
        
        buffer_ptr.pointee = .init(
            bf_getbuffer: unsafeBitCast(getBuffer, to: PyBuf_Get.self),
            bf_releasebuffer: unsafeBitCast(releaseBuffer, to: PyBuf_Release.self)
        )
        
    }
    
}
