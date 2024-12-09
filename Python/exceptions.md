<!-- omit in toc -->
# Exceptions and Errors in Python

<!-- omit in toc -->
## Table of Contents

- [Introduction](#introduction)
- [Handling Exceptions](#handling-exceptions)
- [Raising Exceptions](#raising-exceptions)
- [Advanced Exception Handling](#advanced-exception-handling)
  - [Exception Groups](#exception-groups)
  - [Exception Chaining](#exception-chaining)
  - [Exception Notes](#exception-notes)


## Introduction

Exceptions are errors that occur during the execution of a program.
They interrupt the normal flow of the program and usually end it.
Like in many other languages, in Python, exceptions are split into two categories: Handled and unhandled exceptions.

Handled exceptions are caught by the program and dealt with.
Unhandled exceptions are not caught by the program and end it.

`BaseException` is the base class for all exceptions in Python. 
One of its subclasses is `Exception`, it is used for all exceptions that are non fatal and can be handled.
Exceptions which are not subclasses of `Exception` are typically not handled and are used to indicate that the program should be terminated.

The following diagram shows the hierarchy of the most common exceptions in Python:

![](https://python3.info/_images/exception-hierarchy.png)

> Source: [python3.info](https://python3.info/basics/exception/raise.html)


## Handling Exceptions

Exceptions can be handled using the `try` and `except` statements.
The `try` statement is used to mark a block of code that might raise an exception.
The `except` statement is used to handle the exception.

```python
try:
    # Code that might raise an exception
except:
    # Code that handles the exception
```

The `except` statement can be used with or without an exception type.
If it is used without an exception type, it will catch all exceptions.
If it is used with an exception type, it will only catch exceptions of that certain type.

```python
try:
    # Code that might raise an exception
except ExceptionType:
    # Code that handles the exception
```

The `except` statement can also be used with multiple exception types at once and it can also be used with multiple `except` statements.

```python
try:
    # Code that might raise an exception
except (ExceptionType1, ExceptionType2):
    # Code that handles the exception1 or exception2
except ExceptionType3:
    # Code that handles the exception3
```

You can also use the `as` statement to get the exception object.

```python
try:
    # Code that might raise an exception
except ExceptionType as e:
    # Code that handles the exception
```

There are 2 slightly more advanced statements that can be used with the `try` statement: `else` and `finally`.

The `else` statement is used to mark a block of code that should only be executed if no exception was raised in the `try` block.

```python
try:
    # Code that might raise an exception
except:
    # Code that handles the exception
else:
    # Code that is executed if no exception was raised
```

> Note: This can be used to avoid catching exceptions that are not raised by the code in the `try` block and to clearly separate the code that handles the exception from the code that is executed if no exception was raised.


The `finally` statement is used to mark a block of code that should always be executed, no matter if an exception was raised or not.

```python
try:
    # Code that might raise an exception
except:
    # Code that handles the exception
finally:
    # Code that is always executed

# eg
try:
    f = open("file.txt", "r")
    # Code that might raise an exception
except Error:
    # Code that handles the exception
finally:
    f.close()
```

> Note: This can be used to ensure that resources are always closed, even if an exception was raised.

> Note 2: In case a context manager (`with` statement) can be used, it is recommended to use it instead of the whole `try` statement.


## Raising Exceptions

Exceptions can be raised using the `raise` statement.
It can be used with or without an exception type.
If it is used without an exception type, it will raise the last exception that was raised.
If it is used with an exception type, it will raise an exception of that certain type.

```python
# 1. Raise an exception of type ExceptionType
raise ExceptionType
# 2. Raise an exception of type ExceptionType with a message
raise ExceptionType("Message")
# 3. Raise the last exception that was raised
raise
# 4. Raise the last exception that was raised with a message
raise "Message"
```

> Note: You can raise an exception without instantiating it. In this case, the exception will be instantiated automatically with the default constructor.


## Advanced Exception Handling

### Exception Groups

Multiple exceptions can be raised at once using the `ExceptionGroup` class.
It is a subclass of `Exception` which means that it cannot be used to wrap BaseExceptions.

```python
def function_that_has_multiple_arguments(arg1, arg2, arg3, arg4):
    exceptions = []
    if arg1 is None:
        exceptions.append(ValueError("arg1 is None"))
    if arg2 is None:
        exceptions.append(TypeError("arg2 is None"))
    if arg3 is None:
        exceptions.append(ValueError("arg3 is None"))
    if arg4 is None:
        exceptions.append(OSError("arg4 is None"))

    if len(exceptions) > 0:
        raise ExceptionGroup(exceptions)

    # Code that uses arg1 and arg2

try:
    function_that_has_multiple_arguments(None, None, None, None)
except ExceptionGroup as e:
    for exception in e.exceptions:
        print(exception)
```

And if there are multiple exceptions thrown they can be unpacked and prioritized using the `except*` statement.

```python
try:
    function_that_has_multiple_arguments(None, None, None, None)
except* (ValueError, TypeError) as e:
    print(f"{type(e)}, {e}")
    # Code that handles the ValueError or TypeError
except OSError as e: # This will be executed if 
    print(e)
    # Code that handles the OSError
```

> Note: Please note that the exceptions in the ExceptionGroup must be instantiated, not just the types, this is because in practice these exceptions would have already been raised and caught by the program.

The above code will print the following:

```
ValueError, arg1 is None
TypeError, arg2 is None
ValueError, arg3 is None
arg4 is None
```

### Exception Chaining

It is useful sometimes to catch an exception and then re-raise it or raise a different one.
This can be done using the `raise ... from` statement.

```python
try:
    # Code that might raise an exception
except ExceptionType as e:
    # Code that handles the exception
    raise ExceptionType2("Message") from e
```

The above code will raise an exception of type `ExceptionType2` with the message `Message` and the original exception will be stored in the `__cause__` attribute of the new exception.

By default, the nested raised exception gets chained to the new exception so in our case the `from e` part is optional.
But if you want to raise a new exception and not chain the nested one, you can use the `from None` statement.

```python
try:
    # Code that might raise an exception
except ExceptionType as e:
    # Code that handles the exception
    raise ExceptionType2("Message") from None
```

> Note: It is recommended to always chain exceptions, unless you have a good reason not to.

> Note 2: Re-raising an exception inside an `except` statement is usually a bad practice. But it can be useful sometimes, for example when you want to add more information to the exception.


### Exception Notes

Exceptions can have notes attached to them.
These notes can be used to add more information to the exception.
They can be added using the `add_note` method of the exception.

```python
try:
    # Code that might raise an exception
except ExceptionType as e:
    # Code that handles the exception
    e.add_note("Note")
    raise
```

> Note: This will re-raise the exception with the note attached to it.
> The notes only have a point if the exception is re-raised, otherwise they are lost.

Near real world example:

```python
def f():
    raise ValueError("ValueError")

exceptions = []
for i in range(10):
    try:
        f()
    except ValueError as e:
        e.add_note(f"i = {i}")
        exceptions.append(e)

raise ExceptionGroup(exceptions)
```