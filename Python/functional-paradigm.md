<!-- omit in toc -->
# Functional Programming in Python

<!-- omit in toc -->
## Table of Contents
- [Introduction](#introduction)
- [`lambda`](#lambda)
- [`map()`](#map)
- [`filter()`](#filter)
- [`reduce()`](#reduce)


## Introduction

Functional programming is a programming paradigm that treats computation as the evaluation of mathematical functions and avoids changing-state and mutable data. 
It is a declarative programming paradigm, which means programming is done with expressions or declarations instead of statements. 
In functional code, the output value of a function depends only on the arguments that are passed to the function, so calling a function f twice with the same value for an argument x will produce the same result f(x) each time. 
Eliminating side effects, i.e. changes in state that do not depend on the function inputs, can make it much easier to understand and predict the behavior of a program, which is one of the key motivations for the development of functional programming.

Functional programming has its roots in lambda calculus, a formal system developed in the 1930s to investigate function definition, function application, and recursion.

In Python, functions are first-class objects. This means that functions can be passed around and used as arguments, just like any other object (string, int, float, list, and so on).
This opens up a lot of possibilities for functional programming in Python.

The most common functions used in functional programming are:
- `map()`
- `filter()`
- `reduce()` (in Python 2, in Python 3 it is in the `functools` module)
- `lambda`

So let's take a look at them.

## `lambda`

`lambda` is a keyword in Python that is used to create anonymous/lambda functions.
These anonymous functions can only take one expression and they can't contain any statements.
Eg:
```python
# This is a normal function
def func1(x):
    return x + 1

# This is an anonymous function
func2 = lambda x: x + 1
```

Both of the above can be called like this:
```python
func1(1) # 2
func2(1) # 2
```

In general, `lambda` functions are used when we need to pass a function as an argument to another function.

> **NOTE 1**: `lambda` functions can be used to create functions that return other functions. This is called a closure. For example:
> ```python
> def func(x):
>     return lambda y: x + y
>
> func1 = func(1)
> func1(2) # 3
> ```

> **NOTE 2**: `lambda` functions can have 0 to any number of arguments. For example:
> ```python
> func = lambda: 1
> func() # 1
>
> func = lambda x, y: x + y
> func(1, 2) # 3
> ```


## `map()`

Map applies a function to all the items of an iterable object (lists, generators, etc). 
Here is the blueprint:

```python
map(function_to_apply, list_of_inputs)
```

For example, if we want to multiply all the items in a list by 2, we can do it like this:
```python
my_list = [1, 2, 3, 4, 5]
result = map(lambda x: x * 2, my_list)
print(list(result)) # [2, 4, 6, 8, 10]
```

> **NOTE 1**: `map()` returns an iterator, so we need to convert it to a list to see the result.

We can also pass multiple iterable objects to `map()`:
```python
my_list1 = [1, 2, 3, 4, 5]
my_list2 = [6, 7, 8, 9, 10]
result = map(lambda x, y: x + y, my_list1, my_list2)
print(list(result)) # [7, 9, 11, 13, 15]
```


## `filter()`

Filter creates an iterator of elements for which a function returns true.

```python
filter(function_to_apply, list_of_inputs)
```

For example, if we want to filter out all the odd numbers from a list, we can do it like this:
```python
my_list = [1, 2, 3, 4, 5]
result = filter(lambda x: x % 2 == 0, my_list)
print(list(result)) # [2, 4]
```

> **NOTE 1**: `filter()` returns an iterator, so we need to convert it to a list to see the result.

We can also pass multiple iterable objects to `filter()`:
```python
my_list1 = [1, 2, 3, 4, 5]
my_list2 = [6, 7, 8, 9, 10]
result = filter(lambda x, y: x % 2 == 0 and y % 2 == 0, my_list1, my_list2)
print(list(result)) # [(2, 6), (4, 8)]
```

> **NOTE 2**: `filter()` can also be used to filter out `None` values or empty strings from a list. For example:
> ```python
> my_list = [1, 2, None, 3, 4, None, 5]
> result = filter(None, my_list)
> print(list(result)) # [1, 2, 3, 4, 5]
> ```
>
> This just filters out all the values that are treated as `False` in Python. Namely: `None`, `False`, `0`, `0.0`, `0j`, `''`, `[]`, `{}`, `()` and the objects that implement `__bool__()` and return `False` or implement `__len__()` and return `0`.
>
> **IMPORTANT SIDE-NOTE**: Depending on your data, in some cases `0` might be useful, so the above might not be the safest way to filter numbers.


## `reduce()`

Reduce is a really useful function for performing some computation on a list and returning the result.
It applies a rolling computation to sequential pairs of values in a list.

```python
reduce(function_to_apply, list_of_inputs)
```

For example, if we want to sum all the numbers in a list, we can do it like this:
```python
from functools import reduce

my_list = [1, 2, 3, 4, 5]
result = reduce(lambda x, y: x + y, my_list)
print(result) # 15
```

> **NOTE 1**: `reduce()` is not a built-in function in Python 3, so we need to import it from the `functools` module.

The above is equivalent to the following:
```python
my_list = [1, 2, 3, 4, 5]
result = 0
for x in my_list:
    result += x
print(result) # 15
```

> **NOTE 2**: `reduce()` can also take an optional third argument which is the initial value of the computation. For example:
> ```python
> from functools import reduce
>
> my_list = [1, 2, 3, 4, 5]
> result = reduce(lambda x, y: x + y, my_list, 10)
> print(result) # 25
> ```