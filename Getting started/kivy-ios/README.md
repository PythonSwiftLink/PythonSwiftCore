# 1. Setup a kivy-ios environment and create a project 

[https://github.com/kivy/kivy-ios#kivy-for-ios](https://github.com/kivy/kivy-ios#kivy-for-ios)

[https://youtu.be/Etk4ky18Xb0](https://youtu.be/Etk4ky18Xb0)

```shell
mkdir my_ios_folder
cd my_ios_folder

python3.10 -m venv venv
. venv/bin/activate
pip install git+https://github.com/PythonSwiftLink/kivy-ios

toolchain build python3 
toolchain build kivy
toolchain build swiftonize
```

<<<<<<< Updated upstream
# temporary test folder for this tutorial

```shell
mkdir py_src
touch py_src/main.py
toolchain create my_app py_src
```
=======
```
mkdir py_src
touch py_src/main.py
>>>>>>> Stashed changes

toolchain create my_app py_src
toolchain xcode my_app-ios
```



everytime u add a new wrapper.py to wrapper_sources

run this:

```
toolchain update my_app-ios
```



Xcode will automatic generate new .swift versions of your wrappers.py when u run build in xcode

so toolchain update only needed to add all new wrappers.swift the first time you build it.



Swift versions of the plyer lib, more coming later on.

[https://github.com/PythonSwiftLink/SwiftTools/tree/main/src/swift_tools/plyer](https://github.com/PythonSwiftLink/SwiftTools/tree/main/src/swift_tools/plyer)

other kinds of swift wraps:

https://github.com/PythonSwiftLink/SwiftTools/tree/main/src/swift_tools/standard

examples of wrapping an existing apple class directly 

https://github.com/PythonSwiftLink/SwiftTools/tree/main/src/swift_tools/apple
