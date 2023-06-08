import Foundation

#if BEEWARE
import PythonLib
#endif

public final class PySwiftModuleImport {
    let name: CString
    let module: PythonModuleImportFunc
    
    
    public init(name: String, module: PythonModuleImportFunc) {
        self.name = makeCString(from: name)
        self.module = module
    }
}
