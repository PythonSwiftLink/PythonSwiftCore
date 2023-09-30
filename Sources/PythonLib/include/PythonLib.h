//
//  PythonLib.h
//  
//
//  Created by MusicMaker on 08/09/2022.
//

#ifndef PythonLib_h
#define PythonLib_h


#include <stdio.h>
#include <stdbool.h>

#include "Python.h"

#include "datetime.h"
#include "structmember.h"
#include "methodobject.h"

bool PythonDict_Check(PyObject* o);
int _PythonDict_Check(PyObject* o);
bool PythonTuple_Check(PyObject* o);
bool PythonList_Check(PyObject* o);
bool PythonUnicode_Check(PyObject* o);
bool PythonLong_Check(PyObject *o);
bool PythonFloat_Check(PyObject *o);
bool PythonBool_Check(PyObject *o);
bool PythonByteArray_Check(PyObject *o);
bool PythonBytes_Check(PyObject *o);
bool PythonMemoryView_Check(PyObject *o);
bool PythonObject_TypeCheck(PyObject *o, PyTypeObject *type);

PyObject** PythonSequence_Fast_ITEMS(PyObject *o);
PyObject* PythonSequence_Fast_GET_ITEM(PyObject *o, Py_ssize_t i);
Py_ssize_t PythonSequence_Fast_GET_SIZE(PyObject *o);
Py_buffer *PythonMemoryView_GET_BUFFER(PyObject *mview);


uint Python_TPFLAGS_DEFAULT;

void* PythonUnicode_DATA(PyObject *o);
unsigned int PythonUnicode_KIND(PyObject *o);

Py_UCS1 *PythonUnicode_1BYTE_DATA(PyObject *o);
Py_UCS2 *PythonUnicode_2BYTE_DATA(PyObject *o);
Py_UCS4 *PythonUnicode_4BYTE_DATA(PyObject *o);

//PyCFunction_NewEx(<#ML#>, <#SELF#>, <#MOD#>)

PyObject* PythonDelta_FromDSU(int days, int seconds, int useconds);
PyObject* PythonNone;
PyObject* PythonTrue;
PyObject* PythonFalse;

PyObject* returnPyNone();
PyObject* PyNoneNew();


typedef struct {
    PyObject_HEAD
    PyObject* dict;
    void* swift_ptr;
} PySwiftObject;

PyModuleDef_Base PythonModuleDef_HEAD_INIT;
//PyMemberDescrObject
//void PythonVarObject_HEAD_INIT();
//PyVarObject PythonVarObject_HEAD_INIT;
PyVarObject PythonObject_Head();

PyObject* Py_Module_Create(PyModuleDef *def );

PyTypeObject NewPyType();
static PyObject* Custom_new(PyTypeObject *type);

PySwiftObject* PySwiftObject_Cast(PyObject* o);

long PySwiftObject_dict_offset;
long PySwiftObject_size;

PyObject* PySwiftObject_New(PyTypeObject *type);
PyObject* _PySwiftObject_New(PyTypeObject* t);

PyCFunction Vectorcall2PyCFunction(vectorcallfunc func);

PyCFunction PyCFunctionFast_Cast(_PyCFunctionFast func);
PyCFunction PyCFunctionFastWithKeywords_Cast(_PyCFunctionFastWithKeywords func);

PyCFunction PyCMethod_Cast(PyCMethod func);



//int _PyArg_VaParseTupleAndKeywords(PyObject *args, PyObject *kw,
//                                   const char *format, char **keywords, va_list vargs );
//

long _PyTuple_GET_SIZE(PyObject *p);

long _PyDict_GET_SIZE(PyObject *p);

#endif /* PythonLib_h */
