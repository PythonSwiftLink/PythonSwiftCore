//
//  TypeAliases.swift
//  Kivy-iOS
//
//  Created by MusicMaker on 23/09/2022.
//

import Foundation

#if BEEWARE
import PythonLib
#endif

public typealias PythonType = UnsafeMutablePointer<PyTypeObject>?
public typealias PySwiftObjectPointer = UnsafeMutablePointer<PySwiftObject>?
public typealias PythonPointer = UnsafeMutablePointer<PyObject>?
public typealias PyPointer = PythonPointer

protocol PyObjectProtocol {}
extension PythonPointer: PyObjectProtocol {}

public typealias PythonPointerU = UnsafeMutablePointer<PyObject>
public typealias PySequenceBuffer = UnsafeBufferPointer<UnsafeMutablePointer<PyObject>?>

public typealias CString = UnsafePointer<CChar>
public typealias MutableCString = UnsafeMutablePointer<CChar>

public typealias PythonModuleImportFunc = @convention(c) () -> PythonPointer
public typealias PySwiftModuleImport = (CString, PythonModuleImportFunc)


public typealias PyGetter = (@convention(c) (_ s: PythonPointer, _ raw: UnsafeMutableRawPointer?) -> PythonPointer)?
public typealias PySetter = (@convention(c) (_ s: PythonPointer,_ key: PythonPointer, _ raw: UnsafeMutableRawPointer?) -> Int32)?

public typealias PyCFunc = (@convention(c) (_ s: PythonPointer, _ args: PythonPointer) -> PythonPointer)?

public typealias VectorArgs = UnsafePointer<PythonPointer>?
public typealias PyCVectorCallKeywords = (@convention(c) ( _ s: PythonPointer, _ args: VectorArgs, _ count: Int, _ kwnames: PythonPointer ) -> PythonPointer )?
public typealias PyCVectorCall = (@convention(c) ( _ s: PythonPointer, _ args: VectorArgs, _ count: Int ) -> PythonPointer )?
public typealias PyCMethodVectorCall = (@convention(c) ( _ s: PythonPointer, _ type: PythonType, _ args: VectorArgs, _ count: Int, _ kwnames: PythonPointer ) -> PythonPointer )?
 
//PySequence Methods

public typealias PySequence_Length_func = (@convention(c) (_ s: PyPointer) -> Py_ssize_t )?
public typealias PySequence_Concat_func = (@convention(c) (_ lhs: PyPointer,_ rhs: PyPointer) -> PyPointer)?
public typealias PySequence_Repeat_func = (@convention(c) (_ s: PyPointer,_ count: Py_ssize_t) -> PyPointer)?
public typealias PySequence_Item_func = (@convention(c) (_ s: PyPointer,_ idx: Py_ssize_t) -> PyPointer)?
public typealias PySequence_Ass_Item_func = (@convention(c) (_ s: PyPointer,_ idx: Py_ssize_t,_ item: PyPointer) -> Int32)?
public typealias PySequence_Contains_func = (@convention(c) (_ s: PyPointer,_ o: PyPointer) -> Int32)?
public typealias PySequence_Inplace_Concat_func = (@convention(c) (_ lhs: PyPointer,_ rhs: PyPointer) -> PyPointer)?
public typealias PySequence_Inplace_Repeat_func = (@convention(c) (_ s: PyPointer,_ count: Py_ssize_t) -> PyPointer)?


public typealias PyBuf_Get = (@convention(c) (_ s: PyPointer,_ buf: UnsafeMutablePointer<Py_buffer>?,_ flags: Int32) -> Int32)?
public typealias PyBuf_Release = (@convention(c) (_ s: PyPointer,_ buf: UnsafeMutablePointer<Py_buffer>?) -> Void )?
