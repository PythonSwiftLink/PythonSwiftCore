//
//  PythonLib.c
//  
//
//  Created by MusicMaker on 08/09/2022.
//

#include "PythonLib.h"

bool PythonDict_Check(PyObject* o) { return PyDict_Check(o) == 1; }
int _PythonDict_Check(PyObject* o) { return PyDict_Check(o); }
bool PythonTuple_Check(PyObject* o) { return PyTuple_Check(o) == 1; }
bool PythonList_Check(PyObject* o) { return PyList_Check(o) == 1; }
bool PythonUnicode_Check(PyObject* o) { return PyUnicode_Check(o) == 1; }
bool PythonLong_Check(PyObject *o) { return PyLong_Check(o) == 1; }
bool PythonFloat_Check(PyObject *o) { return PyFloat_Check(o) == 1; }
bool PythonBool_Check(PyObject *o){ return PyBool_Check(o) == 1; }
bool PythonByteArray_Check(PyObject *o) { return PyByteArray_Check(o) == 1; }
bool PythonBytes_Check(PyObject *o) { return PyBytes_Check(o) == 1; }
bool PythonObject_TypeCheck(PyObject *o, PyTypeObject *type) { return PyObject_TypeCheck(o, type) == 1; }
bool PythonMemoryView_Check(PyObject *o) { return PyMemoryView_Check(o) == 1; }

PyObject** PythonSequence_Fast_ITEMS(PyObject *o) { return PySequence_Fast_ITEMS(o); }
PyObject* PythonSequence_Fast_GET_ITEM(PyObject *o, Py_ssize_t i) { return PySequence_Fast_GET_ITEM(o, i); }
Py_ssize_t PythonSequence_Fast_GET_SIZE(PyObject *o) { return PySequence_Fast_GET_SIZE(o); }

PyObject* PythonDelta_FromDSU(int days, int seconds, int useconds) { return PyDelta_FromDSU(days, seconds, useconds);}
Py_buffer *PythonMemoryView_GET_BUFFER(PyObject *mview) { return PyMemoryView_GET_BUFFER(mview);}

uint Python_TPFLAGS_DEFAULT = Py_TPFLAGS_DEFAULT;

void* PythonUnicode_DATA(PyObject *o) { return PyUnicode_DATA(o);}
unsigned int PythonUnicode_KIND(PyObject *o) {return  PyUnicode_KIND(o);}

Py_UCS1 *PythonUnicode_1BYTE_DATA(PyObject *o) { return PyUnicode_1BYTE_DATA(o); }
Py_UCS2 *PythonUnicode_2BYTE_DATA(PyObject *o) { return PyUnicode_2BYTE_DATA(o); }
Py_UCS4 *PythonUnicode_4BYTE_DATA(PyObject *o) { return PyUnicode_4BYTE_DATA(o); }
PyObject* PythonNone = Py_None;
PyObject* PythonTrue = Py_True;
PyObject* PythonFalse = Py_False;
PyObject* returnPyNone() {
    Py_INCREF(Py_None);
    return Py_None;
}
PyObject* PyNoneNew() {
    Py_INCREF(Py_None);
    return Py_None;
}
PyModuleDef_Base PythonModuleDef_HEAD_INIT = PyModuleDef_HEAD_INIT;

PyVarObject PythonObject_Head() {PyObject_HEAD; }

PyObject* Py_Module_Create(PyModuleDef *def ) { PyModule_Create(def); }

long PySwiftObject_dict_offset = offsetof(PySwiftObject, dict);
long PySwiftObject_size = sizeof(PySwiftObject);

PySwiftObject* PySwiftObject_Cast(PyObject* o) {
    return (PySwiftObject *) o;
}


//static PyObject* Custom_new(PyTypeObject *type) { Custom}
//typedef PyVarObject_HEAD_INIT PythonVarObject_HEAD_INIT;
PyTypeObject NewPyType() {
    PyTypeObject t = {
        PyVarObject_HEAD_INIT(NULL, 0)
    };
    //printf("offsetof(PySwiftObject, dict)\n");
    //char str[15];
    //sprintf(str, "%d", PySwiftObject_dict_offset);
    //printf(str);
    //printf();
    //printf("\n");
    return t;
}
//PyCFunction_GET_FUNCTION(func)


PyObject* PySwiftObject_New(PyTypeObject *type) {
    //PySwiftObject* self;
    //self = (PySwiftObject *) type->tp_alloc(type, 0);
    //return (PyObject *) self;
    return type->tp_alloc(type, 0);
    //return NULL;
}

PyObject* _PySwiftObject_New(PyTypeObject* t) {
    return (PyObject*)PyObject_New(PySwiftObject, t);
}


PyCFunction Vectorcall2PyCFunction(vectorcallfunc func) { return (PyCFunction) func;  }

PyCFunction PyCFunctionFast_Cast(_PyCFunctionFast func) { return (PyCFunction) func; }

PyCFunction PyCFunctionFastWithKeywords_Cast(_PyCFunctionFastWithKeywords func) { return (PyCFunction) func; }

PyCFunction PyCMethod_Cast(PyCMethod func) { return (PyCFunction) func; }


//int _PyArg_VaParseTupleAndKeywords(PyObject *args, PyObject *kw,
//                                   const char *format, char **keywords, va_list vargs ) {PyArg_VaParseTupleAndKeywords(args, kw, format, keywords, vargs);};

long _PyTuple_GET_SIZE(PyObject *p) {return PyTuple_GET_SIZE(p);}

long _PyDict_GET_SIZE(PyObject *p) {return PyDict_GET_SIZE(p);}


