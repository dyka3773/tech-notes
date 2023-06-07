<!-- omit in toc -->
# Python Decorators

<!-- omit in toc -->
## Table of Contents
- [Function Decorators](#function-decorators)
- [Class Decorators](#class-decorators)
- [Arguments in Decorators](#arguments-in-decorators)
- [Nested Decorators](#nested-decorators)


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

> **Note**: Please note that the `decorator_func` is exactly the same as the one used for [function decorators](#function-decorators), it has zero changes in it except for the name of the argument, which, since Python is a dynamically typed language, can be anything.


## Arguments in Decorators

You can also create more complex decorators that take arguments.
In order to achieve that, you need to create a decorator factory that will return a decorator.
This basically means that you can add another layer of abstraction to your decorators.

In order to see that in action, let's create a decorator that will print the time it took for a function to execute.
We can do it like this:

```python
from functools import wraps
from time import time

def timer(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time()
        result = func(*args, **kwargs)
        end = time()
        print(f'Time elapsed: {end - start}')
        return result
    return wrapper

@timer
def func():
    pass
```

Now, if we call `func()`, it will print the time it took for it to execute. 

We can also create a decorator that will print the time it took for a function to execute *only if the function took more than a certain amount of time to execute*. 
We can do it like this:

```python
from functools import wraps
from time import time

def timer(min_time=0):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            start = time()
            result = func(*args, **kwargs)
            end = time()
            if end - start > min_time:
                print(f'Time elapsed: {end - start}')
            return result
        return wrapper
    return decorator

@timer(min_time=1)
def func():
    pass
```

Now, if we call `func()`, it will print the time it took for it to execute *only if it took more than 1 second to execute*.

This works because the `timer` function is a decorator factory that returns a decorator which is then used to decorate the `func` function.

> I know that this is a bit confusing, but it is a very powerful feature of Python and it is worth learning it.
> If you want to learn more about decorators, I recommend reading [this article](https://realpython.com/primer-on-python-decorators/).


## Nested Decorators

You can also nest decorators.
This means that you can use a decorator to decorate another decorator.
You can do this by just stacking the decorators on top of each other.

For example, let's say that we have a decorator that will print the time it took for a function to execute and another decorator that will execute a function multiple times.
We can do it like this:

```python
from functools import wraps
from time import time

def timer(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time()
        result = func(*args, **kwargs)
        end = time()
        print(f'Time elapsed: {end - start}')
        return result
    return wrapper

def repeat(n=1):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for _ in range(n):
                result = func(*args, **kwargs)
            return result
        return wrapper
    return decorator

@timer
@repeat(n=3)
def func():
    print('Hello World!')
```

Now, if we call `func()`, it will print `Hello World!` 3 times and it will print the time it took for it to execute.

But if we had used the decorators in the opposite order, like this:

```python
@repeat(n=3)
@timer
def func():
    print('Hello World!')
```

Then it would have printed `Hello World!` 3 times, but it would have printed the time it took for it to execute three times as well (once for each time it was executed).

