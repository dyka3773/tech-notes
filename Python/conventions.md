<!-- omit in toc -->
# Python Conventions

<!-- omit in toc -->
## Table of Contents
- [Intro](#intro)
- [Casing](#casing)
- [Example Conventions](#example-conventions)
- [`this` and `self`](#this-and-self)
- [`self` vs `cls`](#self-vs-cls)
- [`*args` and `**kwargs`](#args-and-kwargs)
- [General Coding Style](#general-coding-style)

## Intro

Naming conventions are important in programming because they make the code more readable and understandable.
In Python, there are several naming conventions that are used for different purposes.

Most of the developers in the Python community follow the coding style that is defined in [PEP 8](https://www.python.org/dev/peps/pep-0008/).
Some of the most important points of this style guide are highlighted in this document.


## Casing

There are 4 types of casing in Python:
- `snake_case` : All lowercase letters and words are separated by underscores. This is used for `variable` names, `function` names, `module` names, etc.
- `PascalCase` : All words are capitalized and there are no separators. This is used for `class` names.
- `camelCase` : All words are capitalized except the first one and there are no separators. This is also used for `class` names, but it is less common than `PascalCase`.
- `UPPER_CASE` : All letters are capitalized and words are separated by underscores. This is used for `constants`.


## Example Conventions

When seeing examples of Python code online, you will notice that the really common `foo`, `bar` and `baz` are not used. 
Instead, you will see `spam`, `ham` and `eggs`.


## `this` and `self`

In Python, `this` is not a keyword and also the first argument of a method is always a reference to the object itself.
Thus, a common convention is to use `self` or `this` as the first argument of a method, with which you can access the class's instance and class variables.

```python
class Foo:
    def __init__(self, x):
        self.x = x

    def bar(self):
        print(self.x)

foo = Foo(1)
foo.bar() # 1
```

## `self` vs `cls`

Even though `self` is the most common name used for the first argument of a method, `cls` is also used in class methods to refer to the class itself.
Python will still pass the class reference as the first argument to the method, but it is a convention to use `cls` instead of `self` in class methods.

```python
class Foo:
    x = 0

    @classmethod
    def bar(cls):
        cls.x += 1
        print(cls.x)

Foo.bar() # 1
Foo.bar() # 2
```

## `*args` and `**kwargs`

`*args` and `**kwargs` are used to pass a variable number of arguments to a function.
`*args` is used to pass a variable number of **positional** arguments and `**kwargs` is used to pass a variable number of **keyword** arguments.

See [Python Arguments](./arguments.md/#variable-number-of-arguments) for more information.

The names `args` and `kwargs` are just a convention and you can use any other names but it is recommended to stick to the convention.


## General Coding Style

- Use 4 spaces for indentation.
- Use 1 space after commas and colons.
- Use 2 blank lines between top-level functions and classes.
- Use 1 blank line between methods in a class.
- Use 1 blank line before a `return` statement.
- Wrap lines that are longer than 79 characters.
- Use `"""docstrings"""` to document classes, methods and functions.
- Use `#` for comments.
- Don't use fancy encodings if your code is meant to be used in international environments. Plain ASCII works best in any case. (Even though Python 3 supports UTF-8 by default)