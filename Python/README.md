<!-- omit in toc -->
# Python

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
  - [Windows](#windows)
  - [Linux](#linux)
- [Hello World](#hello-world)
- [Types](#types)
- [Variables](#variables)
- [Comments](#comments)
- [Variable Scope](#variable-scope)
- [Advanced (Quirky) Python Features To Explore](#advanced-quirky-python-features-to-explore)


## Introduction

Python is a high-level, general-purpose, interpreted, dynamic programming language. It was created by Guido van Rossum and first released in 1991. It is used for web development (server-side), software development, mathematics, system scripting, data science, machine learning, and more.

## Installation

### Windows

1. Download the latest version of Python from [here](https://www.python.org/downloads/windows/).
2. Run the installer.
3. Check the "Add Python 3.x to PATH" checkbox.
4. Follow the instructions in the installer.

### Linux

1. Open a terminal.
2. Run the following command:
```bash
sudo apt install python3
```

## Hello World

```python
print("Hello World")
```

## Types

Python has the following built-in types:
- Text Type: `str` ("Hello World")
- Numeric Types: `int`, `float`, `complex` (1, 1.5, 1j)
- Sequence Types: `list`, `tuple`, `range` ([1, 2, 3], (1, 2, 3), range(1, 4))
- Mapping Type: `dict` ({'name': 'John', 'age': 36})
- Set Types: `set`, `frozenset` ({1, 2, 3}, frozenset({1, 2, 3}))
- Boolean Type: `bool` (True, False)
- Binary Types: `bytes`, `bytearray`, `memoryview` (b"Hello", bytearray(5), memoryview(bytes(5)))

And of course, we can create our own types by using classes.


## Variables

Variables are containers for storing data values. Unlike other programming languages, Python has no command for declaring a variable. A variable is created the moment you first assign a value to it.

```python
x = 5
y = "John"
print(x)
print(y)
```

Variables do not need to be declared with any particular type and can even change type after they have been set.

```python
x = 4 # x is of type int
x = "Sally" # x is now of type str
print(x)
```

String variables can be declared either by using single or double quotes.

```python
x = "John"
# is the same as
x = 'John'
```
> **Note 1**: Triple quotes are used to span the string across multiple lines.
> ```python 
> x = """Lorem ipsum dolor sit amet,
> consectetur adipiscing elit,
> sed do eiusmod tempor incididunt
> ut labore et dolore magna aliqua."""
> ```


Variable names are case-sensitive.

```python
a = 4
A = "Sally"
# A will not overwrite a
```

Variable names must start with a letter or the underscore character.

```python
# Legal variable names:
myvar = "John"
my_var = "John"
_my_var = "John"
myVar = "John"
MYVAR = "John"
myvar2 = "John"

# Illegal variable names:
2myvar = "John"
my-var = "John"
my var = "John"
```

> **Note 2**: Variable names can only contain alpha-numeric characters and underscores.

> **Note 3**: For the naming convention of variables, see [this note](conventions.md/#casing).


## Comments

Comments are used to explain certain lines of code in plain English. They are not executed when the code is run.

```python
# This is a single-line comment

"""
This is a multi-line comment
"""
```

> **Note**: Triple quotes are used to span the comment across multiple lines, to create multi-line strings and to create docstrings.


## Variable Scope

A variable is only available from inside the region it is created. This is called scope.

```python
def myfunc():
  x = 300
  print(x)

myfunc() # This will print 300
print(x) # While this will cause an error
```

In Python, variables that are created outside of a function (as in all of the examples above) are known as global variables. Global variables can be used by everyone, both inside of functions and outside.

```python
x = 300

def myfunc():
  print(x)

myfunc() # This will print 300
print(x) # And this will also print 300
```

If you create a variable with the same name inside a function, this variable will be local, and can only be used inside the function. The global variable with the same name will remain as it was, global and with the original value.

```python
x = 300

def myfunc():
  x = 200
  print(x)

myfunc() # This will print 200
print(x) # While this will print 300
```

The `global` keyword makes the variable global.

```python
def myfunc():
  global x
  x = 300

myfunc() # This will print 300
print(x) # And this will also print 300
```
> **Note**: This is not recommended, as it can cause confusion and lead to bugs. 


## Advanced (Quirky) Python Features To Explore

As in every language, there are many features that are idiomatic to Python. 
My suggestion is to explore them as you go along.

I have also appended my notes on some these features in case they might be of help.

Here are some of these features:

- List Comprehension
  > [My Notes](./functional-paradigm.md/#list-comprehension) on this
- Lambda Functions
  > [My Notes](./functional-paradigm.md/#lambda) on this
- Function Attributes
- Decorators
  > [My Notes](./decorators.md) on this
- Generators
- f-strings and their shorthand
  > [Official Docs](https://docs.python.org/3/reference/lexical_analysis.html#f-strings)

  
<!-- FIXME: Enhance this as you go -->