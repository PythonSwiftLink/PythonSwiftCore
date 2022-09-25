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
public typealias PythonPointerU = UnsafeMutablePointer<PyObject>
public typealias PySequenceBuffer = UnsafeBufferPointer<UnsafeMutablePointer<PyObject>?>


public typealias PythonModuleImportFunc = @convention(c) () -> PythonPointer

public typealias CString = UnsafePointer<CChar>

public typealias MutableCString = UnsafeMutablePointer<CChar>

public typealias PyGetter = (@convention(c) (_ s: PythonPointer, _ raw: UnsafeMutableRawPointer?) -> PythonPointer)?
public typealias PySetter = (@convention(c) (_ s: PythonPointer,_ key: PythonPointer, _ raw: UnsafeMutableRawPointer?) -> Int32)?

public typealias PyCFunc = (@convention(c) (_ s: PythonPointer, _ args: PythonPointer) -> PythonPointer)?

public typealias VectorArgs = UnsafePointer<PythonPointer>?
public typealias PyCVectorCallKeywords = (@convention(c) ( _ s: PythonPointer, _ args: VectorArgs, _ count: Int, _ kwnames: PythonPointer ) -> PythonPointer )?
public typealias PyCVectorCall = (@convention(c) ( _ s: PythonPointer, _ args: VectorArgs, _ count: Int ) -> PythonPointer )?
public typealias PyCMethodVectorCall = (@convention(c) ( _ s: PythonPointer, _ type: PythonType, _ args: VectorArgs, _ count: Int, _ kwnames: PythonPointer ) -> PythonPointer )?
 
