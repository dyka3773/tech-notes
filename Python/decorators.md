<!-- omit in toc -->
# Python Decorators

<!-- omit in toc -->
## Table of Contents
- [Function Decorators](#function-decorators)
- [Class Decorators](#class-decorators)


## Function Decorators

```python
from functools import wraps

def decorator_func(function):
    @wraps(function)
    def wrapper_func(*args, **kwargs):
        # Do something before
        result = function(*args, **kwargs)
        # Do something after
        return result
    return wrapper_func

@decorator_func
def func(x, y): # This could also be `func()` without any arguments
    pass
```

In the example above, the `decorator_func` is a function that takes another function as an argument and returns a new function. The new function is called `wrapper_func` and it is the one that will be called when we call `func`. The `wrapper_func` will call `func` and return its result. The `wrapper_func` can also do something before and/or after calling `func`. **It basically works as an interceptor for the `func` function.**

`*args` are the positional arguments and `**kwargs` are the keyword arguments. The `*` and `**` are used to unpack the arguments. For example, if we have a list `l = [1, 2, 3]` and we want to pass it as arguments to a function, we can do it like this: `func(*l)`. This will unpack the list and pass its elements as arguments to the function. The same goes for dictionaries. If we have a dictionary `d = {'a': 1, 'b': 2}` and we want to pass it as keyword arguments to a function, we can do it like this: `func(**d)`. This will unpack the dictionary and pass its key-value pairs as keyword arguments to the function.

> **NOTE 1**: The `*` and `**` can also be used when defining a function to accept any number of positional and keyword arguments. For example, `def func(*args, **kwargs): pass` will accept any number of positional and keyword arguments.

By using the following:
```python
@decorator_func
def func(x, y):
    pass
```

It is now equivalent to calling the following:
```python
decorator_func(func)(x, y)
# OR
func = decorator_func(func)
func(x, y)
```

> **NOTE 2**: By using wrapper decorators we might fall into some errors when debugging, especially if we omit the `@wraps(function)` decorator. 
> This is because the `wrapper_func` will have the same name as the function it is wrapping, but it will have a different `__name__` attribute. 
> For example, `func.__name__` will return `wrapper_func` instead of `func`.


## Class Decorators

```python
from functools import wraps

def decorator_func(cls):
    @wraps(cls)
    def wrapper_func(*args, **kwargs):
        # Do something before
        result = cls(*args, **kwargs)
        # Do something after
        return result
    return wrapper_func

@decorator_func
class MyClass:
    pass
```

In the example above, the `decorator_func` is a function that takes a class as an argument and returns a new class. The new class is called `wrapper_func` and it is the one that will be called when we call `MyClass`. The `wrapper_func` will call `MyClass` and return its result. The `wrapper_func` can also do something before and/or after calling `MyClass`. **It basically works as an interceptor for the `MyClass` class.**

<!-- TODO: Describe decorators with arguments -->