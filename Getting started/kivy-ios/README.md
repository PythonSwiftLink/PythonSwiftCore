# 1. Setup a kivy-ios environment and create a project 

[https://github.com/kivy/kivy-ios#kivy-for-ios](url)


# 2. Modify Xcode Project

download the following files:

[AppDelegate.swift](https://raw.githubusercontent.com/PythonSwiftLink/PythonSwiftLinkSupportFiles/main/project_support_files/AppDelegate.swift)

![delete main.m](images/delete_main_m.png)

add **AppDelegate.swift** to the same group(Sources) as the deleted main.m

![AppDelegate.swift](images/AppDelegate.png)



![...](images/AppDelegate2.png)



when adding a swift file to a objc the first time, you will be prompted with the following question:

![create_bridge](images/create_bridge.png)

press Create Bridging Header.

select the Bridging Header file and insert these 2 lines.

```objc
#include "Python.h"
#include "PythonLib.h"
```
![bridge lines](images/bridge_text.png)

now clone the 2 following repos to your kivy-ios folder.

```
git clone --branch main https://github.com/PythonSwiftLink/PythonLib
git clone --branch testing https://github.com/PythonSwiftLink/PythonSwiftCore
```



add the 2 following files from PythonLib to example the classes group

`<your kivy-ios folder>/PythonLib/Sources/PythonLib/include/PythonLib.h`

`<your kivy-ios folder>/PythonLib/Sources/PythonLib/PythonLib.c`

![PythonLib](images/PythonLib_files.png)

![PythonLib](images/PythonLib_files2.png)

now add PythonSwiftCore folder to the Sources Group
`<your kivy-ios folder>/PythonSwiftCore/Sources/PythonSwiftCore`

![PythonSwiftCore](images/pythonswiftcore_0.png)

![PythonSwiftCore](images/pythonswiftcore_1.png)

![PythonSwiftCore](images/pythonswiftcore_2.png)

hopefully your project tree should now look like something like this

![PythonSwiftCore](images/pythonswiftcore_final.png)

Now only 1 error should be remaining (Fixing PythonSwiftImportList Error)

![PythonSwiftImportList](images/pyswiftimport_0.png)

AppDelegate is looking for an Array named PythonSwiftImportList, but doesnt exist yet.

so create a new .swift file, and just name it PythonSwiftImportList.swift

![PythonSwiftImportList](images/pyswiftimport_1.png)

insert the following content

```swift
// PythonSwiftImportList.swift
import Foundation

let PythonSwiftImportList: [PySwiftModuleImport] = [
	//insert PySwiftModule import functions here
]
```

![PythonSwiftImportList](images/pyswiftimport_2.png)