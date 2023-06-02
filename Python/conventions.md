<!-- omit in toc -->
# Python Conventions

<!-- omit in toc -->
## Table of Contents
- [Intro](#intro)
- [Casing](#casing)
- [Example Conventions](#example-conventions)
- [`this` and `self`](#this-and-self)
- [`__init__` vs `__new__`](#__init__-vs-__new__)

## Intro

Naming conventions are important in programming because they make the code more readable and understandable.
In Python, there are several naming conventions that are used for different purposes.


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