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