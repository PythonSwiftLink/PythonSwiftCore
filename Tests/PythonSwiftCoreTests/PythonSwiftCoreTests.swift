import XCTest
@testable import PythonSwiftCore
@testable import PythonLib


fileprivate var pyfunc: PyPointer = nil

private func initPython() {
    let resourcePath = "/Users/musicmaker/Library/Mobile Documents/com~apple~CloudDocs/Projects/xcode_projects/touchBay_files/touchBay/touchBay"
    print(try! FileManager.default.contentsOfDirectory(atPath: resourcePath))
    var config: PyConfig = .init()
    print("Configuring isolated Python...")
    PyConfig_InitIsolatedConfig(&config)
    
    // Configure the Python interpreter:
    // Run at optimization level 1
    // (remove assertions, set __debug__ to False)
    config.optimization_level = 1
    // Don't buffer stdio. We want output to appears in the log immediately
    config.buffered_stdio = 0
    // Don't write bytecode; we can't modify the app bundle
    // after it has been signed.
    config.write_bytecode = 0
    // Isolated apps need to set the full PYTHONPATH manually.
    config.module_search_paths_set = 1
    
    var status: PyStatus
    
    let python_home = "\(resourcePath)/Python"
    
    var wtmp_str = Py_DecodeLocale(python_home, nil)
    
    var config_home: UnsafeMutablePointer<wchar_t>!// = config.home
    
    status = PyConfig_SetString(&config, &config_home, wtmp_str)
    
    PyMem_RawFree(wtmp_str)
    
    config.home = config_home
    
    status = PyConfig_Read(&config)
    
    print("PYTHONPATH:")
    
    let path = "\(resourcePath)/Python/python-stdlib"
    //let path = "\(resourcePath)/"
    
    print("- \(path)")
    wtmp_str = Py_DecodeLocale(path, nil)
    status = PyWideStringList_Append(&config.module_search_paths, wtmp_str)
    
    PyMem_RawFree(wtmp_str)
    
    
    //PyImport_AppendInittab(makeCString(from: "fib"), PyInitFib)
    
    //PyErr_Print()
    
    //let new_obj = NewPyObject(name: "fib", cls: Int.self, _methods: FibMethods)
    print("Initializing Python runtime...")
    status = Py_InitializeFromConfig(&config)
    let code = """
    def pyfunc(a):
        print(a)
    """.replacingOccurrences(of: "    ", with: "\t")
    let kw = PyDict_New()
    let lkw = PyDict_New()
    PyRun_String(string: code, flag: .file, globals: kw, locals: lkw)
    PyErr_Print()
    //pyPrint(lkw)
    pyfunc = lkw["pyfunc"]
    
}

final class PythonSwiftCoreTests: XCTestCase {
    
    

    
    
    func testExample() throws {
        initPython()
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let a: PyPointer = 4.56786442134
        let start_ref = _Py_REFCNT(a)
        
        //print(_Py_REFCNT(a))
        
        PyObject_CallOneArg(pyfunc, a)
        a.decref()
        //print(_Py_REFCNT(a))
        XCTAssertLessThan(_Py_REFCNT(a), start_ref, "decref required after PyObject_CallOneArg")
        //XCTAssertEqual(start_start, _Py_REFCNT(a))
    }
}
