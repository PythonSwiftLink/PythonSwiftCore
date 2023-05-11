# 1. Setup a kivy-ios environment and create a project 

[https://github.com/kivy/kivy-ios#kivy-for-ios](url)



```shell
mkdir my_folder
cd my_folder

python3.10 -m venv venv
. venv/bin/activate
pip install git+https://github.com/PythonSwiftLink/kivy-ios
deactivate
```
due to some weird bug we need to deactivate the venv and activate it again, else it somehow will use original kivy-ios and not this fork.. 
```
. venv/bin/activate

toolchain build pythonswiftcore
toolchain build swiftonize
toolchain build python3
toolchain build kivy
```


