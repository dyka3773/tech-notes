<!-- omit in toc -->
# Python Arguments

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [Positional vs Keyword Arguments](#positional-vs-keyword-arguments)
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


## Positional vs Keyword Arguments

Positional arguments are the arguments that are passed to a function by their position.
For example, in the following function call:
```python
def func(x, y):
    pass

func(1, 2) # `1` is the first positional argument and `2` is the second positional argument.
```

Keyword (or named) arguments are the arguments that are passed to a function by their name. (Their order does not matter.)
For example, in the following function call:
```python
def func(x, y):
    pass

func(x=1, y=2) # `x=1` is the first keyword argument and `y=2` is the second keyword argument.
```

It is also possible to pass both types of arguments to a function.

For example:
```python
def func(x, y):
    pass

func(1, y=2) # `1` is the first positional argument and `y=2` is the second keyword argument.
```

> **NOTE 1**: Positional arguments must come before keyword arguments. For example, `func(1, y=2)` is valid, but `func(x=1, 2)` is not.

In Python 3.8 and later, it is possible to use `/` and `*` to specify which arguments are positional and which are keyword.
For example:
```python
def func(x, y, /, z, w, *, a, b):
    pass

func(1, 2, 3, 4, a=5, b=6) # This is valid
func(1, 2, z=3, w=4, a=5, b=6) # This is also valid
func(1, 2, 3, 4, 5, 6) # This is not valid
func(1, 2, 3, 4, 5, b=6) # This is not valid
```

In this case, `x` and `y` are positional **only** arguments, `z` and `w` are positional or keyword arguments, and `a` and `b` are keyword **only** arguments.

Following that example we can also have positional only arguments and keyword only arguments.
For example:
```python
def func1(x, y, /):
    pass

def func2(*, x, y):
    pass

func1(1, 2) # This is valid
func1(x=1, y=2) # This is not valid

func2(x=1, y=2) # This is valid
func2(1, 2) # This is not valid
```

> **NOTE 2**: This is mostly used when the function is part of an API and you want to prevent the user from passing certain arguments in a certain way.


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

You can also declare a function that accepts a fixed number of positional arguments and any number of keyword arguments.
For example:
```python
def func(x, y, **kwargs):
    pass

func(1, 2, z=3) # kwargs will be {'z': 3}
```

