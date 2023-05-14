<!-- omit in toc -->
# Python Arguments

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [Default Arguments](#default-arguments)
- [Variable Number of Arguments](#variable-number-of-arguments)


## Introduction

Arguments are the values that are passed to a function when it is called.
In Python arguments are neither passed by value nor by reference. 
**They are passed by assignment.**
This means that the function gets a copy of the reference to the object that is passed as an argument, but *if the reference gets reassigned inside the function, the original reference will not be affected.*

There are 2 types of arguments in Python:
- Positional arguments
- Keyword arguments

Positional arguments are the arguments that are passed to a function by their position.
For example, in the following function call:
```python
def func(x, y):
    pass

func(1, 2)
```
`1` is the first positional argument and `2` is the second positional argument.

Keyword arguments are the arguments that are passed to a function by their name.
For example, in the following function call:
```python
def func(x, y):
    pass

func(x=1, y=2)
```
`x=1` is the first keyword argument and `y=2` is the second keyword argument.

> **NOTE 1**: Positional arguments must come before keyword arguments. For example, `func(1, y=2)` is valid, but `func(x=1, 2)` is not.

> **NOTE 2**: Keyword arguments can be passed in any order. For example, `func(y=2, x=1)` is valid.


## Default Arguments

Default arguments are the arguments that have a default value.
If the function is called without passing a value for a default argument, the default value will be used.
For example:
```python
def func(x, y=2):
    pass

func(1) # y will be 2
func(1, 3) # y will be 3
```


## Variable Number of Arguments

Sometimes we don't know how many arguments we will need to pass to a function.
In this case we can use `*args` and `**kwargs` to accept any number of positional and keyword arguments.

`*args` is used to accept any number of positional arguments.
For example:
```python
def func(*args):
    pass

func(1, 2, 3) # args will be (1, 2, 3)
```

`**kwargs` is used to accept any number of keyword arguments.
For example:
```python
def func(**kwargs):
    pass

func(x=1, y=2, z=3) # kwargs will be {'x': 1, 'y': 2, 'z': 3}
```

> **NOTE 1**: `*args` and `**kwargs` can be used together. 
> For example:
> ```python
> def func(*args, **kwargs):
>     pass
>
> func(1, 2, 3, x=1, y=2, z=3) # args will be (1, 2, 3) and kwargs will be {'x': 1, 'y': 2, 'z': 3}
> ```

> **NOTE 2**: `*args` and `**kwargs` can be used when calling a function to unpack a list or a dictionary and pass its elements as positional or keyword arguments to the function.
> For example:
> ```python
> def func(x, y, z):
>     pass
>
> l = [1, 2, 3]
> d = {'x': 1, 'y': 2, 'z': 3}
>
> func(*l) # This is equivalent to func(1, 2, 3)
> func(**d) # This is equivalent to func(x=1, y=2, z=3)
> ```
>
> Please also note that the keywords `args` and `kwargs` are just a convention.
> You can use any other name you want.