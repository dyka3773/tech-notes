<!-- omit in toc -->
# Custom Packages and Modules

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [Packages](#packages)
  - [Regular Packages](#regular-packages)
  - [Namespace Packages](#namespace-packages)
  - [Single Module Packages](#single-module-packages)
- [Imports](#imports)
  - [Relative Imports](#relative-imports)


## Introduction

Every Python file is a module, and every folder containing Python files is a package.

Packages can contain other packages and modules.
This allows you to organize your code into logical groups.


## Packages

Packages can be of 2 types:
* **Regular packages** are packages that contain an `__init__.py` file.
* **Namespace packages** are packages that do not contain an `__init__.py` file.

Let's take a look at them in more detail.


### Regular Packages

Regular packages are packages that contain an `__init__.py` file.

The `__init__.py` file is used to mark directories on disk as Python package directories.

In the simplest case, `__init__.py` can just be an empty file.

But it can also execute initialization code for the package or set the `__all__` variable.

The `__all__` variable is used to define what symbols are exported when `from <package> import *` is used on the package.
See [this][__all__ 1] and [this][__all__ 2] for more information.

Here is an example of a regular package:

```
package/
├── __init__.py
├── module1.py
└── module2.py
```


### Namespace Packages

Namespace packages are a way of splitting a single Python package across multiple directories.

Unlike regular packages, where all modules must be located inside the package directory, a namespace package can span multiple directories on disk.
They also do not require an `__init__.py` file.

I don't have much experience with namespace packages, so I will not go into more detail here.

The simplest thing I can say is that they shouldn't be used unless you have a good reason to do so, because they can lead to problems with importing modules or confusion.

If you want to learn more about them, see [this stackoverflow answer][__init__.py not required].


### Single Module Packages

Single module packages are packages that contain only one module.

They are created by the interpreter when a directory is found that contains only one module.

Here is an example of a single module package:

```
package.py
```


## Imports

Imports are used to import modules, packages, and symbols (functions, variables, etc) from modules and packages.

To import a module, use the `import` keyword followed by the module name:

```py
import module
```

You can also give it an alias to avoid name conflicts. To do that use the `as` keyword:

```py
import module as alias
```

You can also selectively import symbols from a module using the `from` keyword:

```py
from module import symbol1, symbol2
```
> **Note 1**: You can also use the `as` keyword here to give the symbols an alias.
> ```py
> from module import symbol1 as alias1, symbol2 as alias2
> ```

> **Note 2**: You can also use the `*` symbol to import all symbols from a module.
> ```py
> from module import *
> ```
> This is not recommended, because it can lead to name conflicts and confusion.
> Also, the `__all__` variable stored in the module is used to define what symbols are imported when `from module import *` is used, so if it is not defined, no symbols will be imported even if the module contains symbols.

### Relative Imports

Relative imports are used to import modules and packages relative to the current module.

> **Note**: Relative imports are based on the name of the current module. Since the name of the main module is always `__main__`, **relative imports cannot be used in the main module**.

To import a module relative to the current module, use leading dots to indicate the number of parent directories to go up, followed by the module name:

```py
from . import module1
from .. import module2
from ..module3 import symbol
```


<!-- References -->
[__all__ 1]: https://docs.python.org/3/tutorial/modules.html#importing-from-a-package
[__all__ 2]: https://stackoverflow.com/questions/44834/what-does-all-mean-in-python
[__init__.py not required]: https://stackoverflow.com/a/48804718/15552149