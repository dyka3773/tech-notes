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

## `__init__` vs `__new__`

`__init__` is the constructor of the class and it is called after the object has been created.
`__init__` is an instance method and it is used when you want to control the initialization of a new instance.

`__new__` is the method that creates the object and it is called before the object has been created.
`__new__` is a static method and it is used when you want to control the creation of a new instance.

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