# 1. Setup a kivy-ios environment and create a project 

[https://github.com/kivy/kivy-ios#kivy-for-ios](url)



```shell
mkdir my_folder
cd my_folder

python3.10 -m venv venv
. venv/bin/activate
pip install git+https://github.com/PythonSwiftLink/kivy-ios

toolchain build swiftonize
toolchain build pythonswiftcore
toolchain build python3 
toolchain build kivy
```

# temporary test folder for this tutorial

```shell
mkdir py_src
touch py_src/main.py
toolchain create my_app py_src
```

