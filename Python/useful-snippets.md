<!-- omit in toc -->
# Useful Python Snippets

<!-- omit in toc -->
## Table of Contents

- [Debugging](#debugging)
- [Singleton Class](#singleton-class)
- [Caching Function Calls with LRU Cache](#caching-function-calls-with-lru-cache)


## Debugging

Print all the parameters passed to a function and its return value:

```python
from functools import wraps

def debug(func):
    @wraps(func)
    def wrapper_debug(*args, **kwargs):
        args_repr = [repr(a) for a in args]
        kwargs_repr = [f"{k}={v!r}" for k, v in kwargs.items()]
        signature = ", ".join(args_repr + kwargs_repr)
        print(f"Calling {func.__name__}({signature})")
        value = func(*args, **kwargs)
        print(f"{func.__name__!r} returned {value!r}")
        return value
    return wrapper_debug
```

Usage:

```python
@debug
def my_func(a, b, c):
    return a + b + c
```

Result:

```python
>>> my_func(1, 2, 3)
Calling my_func(1, 2, 3)
'my_func' returned 6
6
```

> **Note**: There is a `{v!r}` in the code above.
> What it does is that it calls `repr()` on the value before interpolating it into the string.
> This is equivalent to doing `f"{k}={repr(v)}"`.
> 
> I didn't know about this until I read [this][f-string docs] in the docs.


## Singleton Class

In order to create a singleton class, you can override its `__new__` method to return the same instance every time.

Here is an example:

```python
class MySingletonClass:
    _instance = None

    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls, *args, **kwargs)
        return cls._instance

s1 = Singleton()
s2 = Singleton()
print(s1 is s2) # True
```

or you can use a decorator:

```python
from functools import wraps

def singleton(cls):
    @wraps(cls)
    def wrapper_singleton(*args, **kwargs):
        if not wrapper_singleton.instance:
            wrapper_singleton.instance = cls(*args, **kwargs)
        return wrapper_singleton.instance
    wrapper_singleton.instance = None
    return wrapper_singleton
```

Usage:

```python
@singleton
class MyClass:
    pass

m1 = MyClass()
m2 = MyClass()
print(m1 is m2) # True
```

> **Note**: There is a `wrapper_singleton.instance` in the code above.
> This is a function attribute.
> 
> I know it's weird, but it's a thing in Python.
> 
> You can read more about it in the [PEP proposal][PEP for function attributes] and [this][stackoverflow question about function attributes] StackOverflow question.


## Caching Function Calls with LRU Cache

You can use the `functools.lru_cache` decorator to cache the results of a function call.

Here is an example:

```python
from functools import lru_cache

@lru_cache(maxsize=32)
def fib(n):
    print(f"Calculating fib({n})")
    if n < 2:
        return n
    return fib(n-1) + fib(n-2)
```

Usage:

```python
>>> fib(10)
Calculating fib(10)
Calculating fib(9)
Calculating fib(8)
Calculating fib(7)
Calculating fib(6)
Calculating fib(5)
Calculating fib(4)
Calculating fib(3)
Calculating fib(2)
Calculating fib(1)
Calculating fib(0)
55
>>> fib(5)
5
>>> fib(12)
Calculating fib(12)
Calculating fib(11)
144
```

In the example above, the results of the function calls are cached.
So, when we call `fib(5)` again, it doesn't calculate the result again, but returns the cached result.

> **Note**: You can also use `fib.cache_info()` to get information about the cache.
> 
> There are many other useful functions in the `lru_cache` object.
> 
> You can read more about them in the [docs](https://docs.python.org/3/library/functools.html#functools.lru_cache). 



<!-- References -->

[f-string docs]: https://docs.python.org/3/reference/lexical_analysis.html#f-strings
[PEP for function attributes]: https://peps.python.org/pep-0232/
[stackoverflow question about function attributes]: https://stackoverflow.com/questions/338101/python-function-attributes-uses-and-abuses