<!-- omit in toc -->
# Strings in Python

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [f-Strings](#f-strings)
  - [Expressions](#expressions)
  - [Callables](#callables)
  - [Extra Features](#extra-features)


## Introduction

String literals are used to represent strings in Python.
They can be enclosed in single quotes (`'...'`), double quotes (`"..."`) or triple quotes (`"""..."""`) with the same result. `\` can be used to escape quotes.

```python
>>> 'spam eggs'  # single quotes
'spam eggs'
>>> 'doesn\'t'  # use \' to escape the single quote...
"doesn't"
>>> "doesn't"  # ...or use double quotes instead
"doesn't"
>>> '"Yes," he said.'
'"Yes," he said.'
>>> "\"Yes,\" he said."
'"Yes," he said.'
>>> '"Isn\'t," she said.'
'"Isn\'t," she said.'
```

Triple quoted strings are useful for strings that span multiple lines.
The following example shows a string that spans multiple lines:

```python
>>> print("""This is a very long string
... that spans multiple lines""")
This is a very long string
that spans multiple lines
```

Strings can be concatenated (glued together) with the `+` operator, and repeated with `*`:

```python
>>> # 3 times 'un', followed by 'ium'
>>> 3 * 'un' + 'ium'
'unununium'
```

Two or more string literals (i.e. the ones enclosed between quotes) next to each other are automatically concatenated.

```python
>>> 'Py' 'thon'
'Python'
```

This feature is particularly useful when you want to break long strings:

```python
>>> text = ('Put several strings within parentheses '
...         'to have them joined together.')
>>> text
'Put several strings within parentheses to have them joined together.'
```

> **Note**: The fact that you can do it doesn't mean you should do it. This can make the code less readable.

Strings can be indexed (subscripted), with the first character having index 0.
The `:` sign can also be used to access substrings.

> There is no separate character type; a character is simply a string of size one:

```python
>>> word = 'Python'
>>> word[0]  # character in position 0
'P'
>>> word[:2]  # characters from the beginning to position 2 (excluded)
'Py'
```


## f-Strings

f-Strings provide a concise and convenient way to embed python expressions inside string literals for formatting.
The `f` or `F` prefix before the string indicates that it is an f-string.
The string itself can be formatted in much the same way that you would with `str.format()`.

```python
>>> name = 'Fred'
>>> f"He said his name is {name}."
'He said his name is Fred.'
>>> "He said his name is {name}.".format(name=name)
'He said his name is Fred.'
```

### Expressions

You can put any valid python expression inside the braces and it will be evaluated and formatted.

```python
>>> f"{2 * 37}"
'74'
>>> f"{name.lower()}"
'fred'
```

### Callables

You can call any callable python object inside the braces and it will be evaluated and formatted.

```python
>>> def to_lowercase(input):
...     return input.lower()
...
>>> name = "Eric Idle"
>>> f"{to_lowercase(name)} is funny."
'eric idle is funny.'
```

### Extra Features

f-Strings support some advanced features that you might find useful.

<!-- omit in toc -->
#### **The `!` Conversion Flag**

- `!s` calls `str()` on the result
- `!r` calls `repr()` on the result
- `!a` calls `ascii()` on the result

```python
>>> f"He said his name is {name!r}."
"He said his name is 'Fred'."
```

<!-- omit in toc -->
#### **The `:` Format Specifier**

The `:` format specifier is used to format the result of the expression or call.

```python
>>> pi = 3.14159265359
>>> f"Pi is approximately {pi:.3f}."
'Pi is approximately 3.142.'
```

It can also be used to declare how many characters the field should be wide, and to align numbers:

```python
>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 7678}
>>> for name, phone in table.items():
...     print(f'{name:10} ==> {phone:10d}')
...
Sjoerd     ==>       4127
Jack       ==>       4098
Dcab       ==>       7678
```

<!-- omit in toc -->
#### **The `=` Format Specifier**

The `=` format specifier causes the result of the expression or call to be printed after the `=` sign.

```python
>>> name = "Eric"
>>> f"{name =}"
'name = Eric'
```