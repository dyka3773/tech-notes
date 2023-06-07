<!-- omit in toc -->
# Double Underscore (dunder) Methods and Attributes in Python

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [General purpose dunder methods](#general-purpose-dunder-methods)
- [Dunder methods for representing objects](#dunder-methods-for-representing-objects)
- [Dunder methods for math operations](#dunder-methods-for-math-operations)
- [Dunder methods for comparison or bitwise operations](#dunder-methods-for-comparison-or-bitwise-operations)
- [Dunder methods that are usually used inside statements](#dunder-methods-that-are-usually-used-inside-statements)
- [Dunder attributes](#dunder-attributes)
- [`__name__` and `__main__`](#__name__-and-__main__)
- [`__init__` vs `__new__`](#__init__-vs-__new__)
- [`__init__.py`](#__init__py)


## Introduction

In Python, there are a lot of methods and attributes that start and end with double underscores. 
These are called dunder methods and dunder attributes.
(They are also called magic methods and magic attributes)

Most of them have derived from the early prototypes of Python, and they are used to implement a lot of the language's features.
This means that some of them should not be used directly or overridden, unless you know what you are doing. Plus, some of them are rarely used.

Let's take a look at some of them.

## General purpose dunder methods

- `__init__`: The constructor method. It is called when an object is created from a class and it allows the class to initialize the attributes of the class.

## Dunder methods for representing objects

- `__str__`: The string representation method. It is called when the `str()` or `print()` function are called on an object. (Similar to `toString()` in Java and other languages.) It is meant to be human-readable, aimed at the end-user.
- `__repr__`: The object representation method. It is called when the `repr()` function is called on an object. It is meant to be unambiguous, aimed at the developer. (Useful for debugging.)


## Dunder methods for math operations

Most of these are rarely used, but it's good to know they exist and that they can be overridden.

- `__add__`: The addition method. It is called when the `+` operator is used on an object.
- `__sub__`: The subtraction method. It is called when the `-` operator is used on an object.
- `__mul__`: The multiplication method. It is called when the `*` operator is used on an object.
- `__truediv__`: The true division method. It is called when the `/` operator is used on an object.
- `__floordiv__`: The floor division method. It is called when the `//` operator is used on an object.
- `__mod__`: The modulo method. It is called when the `%` operator is used on an object.
- `__pow__`: The power method. It is called when the `**` operator is used on an object.


## Dunder methods for comparison or bitwise operations

Out of all these, the most important one is `__eq__`, which is used to compare objects for equality.

- `__and__`: The bitwise AND method. It is called when the `&` operator is used on an object.
- `__or__`: The bitwise OR method. It is called when the `|` operator is used on an object.
- `__xor__`: The bitwise XOR method. It is called when the `^` operator is used on an object.
- `__lshift__`: The left shift method. It is called when the `<<` operator is used on an object. (It is rarely used.)
- `__rshift__`: The right shift method. It is called when the `>>` operator is used on an object. (It is rarely used.)
- `__lt__`: The less than method. It is called when the `<` operator is used on an object.
- `__le__`: The less than or equal to method. It is called when the `<=` operator is used on an object.
- `__eq__`: The equal to method. It is called when the `==` operator is used on an object. Be careful when overriding this method, it can lead to unexpected results when comparing objects for equality, especially in a large codebase where the object implementing it is the main business component and it is used in many places.
- `__ne__`: The not equal to method. It is called when the `!=` operator is used on an object.
- `__gt__`: The greater than method. It is called when the `>` operator is used on an object.
- `__ge__`: The greater than or equal to method. It is called when the `>=` operator is used on an object.


## Dunder methods that are usually used inside statements

- `__enter__`: The enter method. It is called when the `with` statement is used on an object. (It is called before the `with` statement's code block is executed.)
- `__exit__`: The exit method. It is called when the `with` statement is used on an object. (It is called even if an exception is raised inside the `with` statement or when the `with` statement ends normally.)
- `__len__`: The length method. It is called when the `len()` function is called on an object.
- `__contains__`: The contains method. It is called when the `in` operator is used on an object.
- `__del__`: The destructor method. It is called when an object is about to be destroyed and it allows the class to perform any cleanup actions. (It is rarely used.)


## Dunder attributes

- `__name__`: The name attribute. It is used to get the name of a module, class, function, method, descriptor, or generator instance.
  > Note: In the case of a module, it is the name of the module with the path stripped off **BUT** it is `"__main__"` if the module is being run directly as the main program.
- `__doc__`: The docstring attribute. It is used to get the docstring of a module, class, function, method, descriptor, or generator instance.
- `__file__`: The file attribute. It is the name of the file in which the class or function was defined. (It is rarely used.)
- `__dict__`: The dictionary attribute. It is the dictionary containing the class's or function's namespace.
- `__all__`: The all attribute. It is a list of strings containing the names of the objects that should be imported when `from <package_or_module_name> import *` is used.
  > **Note**: This attribute is only used when `from <package_or_module_name> import *` is used. It doesn't hide any object (that is not contained in this variable but is present in the module or package) if the user imports that object explicitly. 
  > 
  > See [this][__all__] for more information.


## `__name__` and `__main__`

The `__name__` variable is a special variable that is set for every module and script. When a module is imported, `__name__` is set to the name of the module. When a script is executed, `__name__` is set to `"__main__"`.

> **Note**: This refers to the global variable `__name__` and not to the `__name__` attribute of a class or function. 

Let's take a look at an example:

```python
# File: module.py

print(__name__)
```

```python
# File: script.py

import module

print(__name__)
```

Creating the above files and running them will produce the following output:

```bash
$ python module.py
__main__

$ python script.py
module
__main__
```


## `__init__` vs `__new__`

* `__init__` is the constructor of the class and it is called after the object has been created.
* `__new__` is the method that creates the object and it is called before the object has been created.

---

* `__init__` is an instance method and it is used when you want to control the initialization of a new instance.
* `__new__` is a static method and it is used when you want to control the creation of a new instance.

To be honest, I have never used `__new__` and I can only think of a few cases where it might be useful.

For example, if you want to create a singleton class, you can override `__new__` to return the same instance every time.

```python
class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

s1 = Singleton()
s2 = Singleton()
print(s1 is s2) # True
```


## `__init__.py`

An `__init__.py` file is used to mark directories on disk as Python package directories.
This prevents directories with a common name, such as `string`, unintentionally hiding valid modules that occur later on the module search path.

> **Note**: Having an `__init__.py` file in a directory is not required to import modules from that directory, it will just create a Namespace Package. But it is required if you want to create a regular package. See [my notes](custom-packages-modules.md/#packages) and [this][__init__.py not required] for more information.

In the simplest case, `__init__.py` can just be an empty file.

It usually contains the `__all__` variable, which is used to define what symbols are exported when `from <package> import *` is used on the package. See [this][__all__] for more information.



<!-- References -->

[__all__]: https://stackoverflow.com/questions/44834/what-does-all-mean-in-python
[__init__.py not required]: https://stackoverflow.com/a/48804718/15552149