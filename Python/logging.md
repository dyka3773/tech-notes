<!-- omit in toc -->
# Logging

<!-- omit in toc -->
## Table of Contents
- [Intro](#intro)
- [Basic Usage](#basic-usage)


## Intro

As in every other language logging lets you track events that happen when some software runs. 
You can use it to record which functions were called, when and what errors were raised.

The logging module lets you define a logger object that you can use to log messages. 
You can define multiple loggers and use them to log different messages. 
You can also define multiple handlers for each logger.
A handler is an object that is responsible for logging the messages to a specific location. 
For example, you can define a logger that logs messages to a file and another logger that logs messages to the console or both at the same time.

Each log message has a level.
The 5 built-in levels are:
- `DEBUG`
- `INFO`
- `WARNING`
- `ERROR`
- `CRITICAL`

> **NOTE 1**: Internaly, the logging module uses a number for each level. The numbers are: `DEBUG = 10`, `INFO = 20`, `WARNING = 30`, `ERROR = 40` and `CRITICAL = 50`. There is also a `NOTSET` level which is set to `0` and is used to turn off logging.

## Basic Usage

```python
import logging

# Create and configure a logger
logging.basicConfig(
    filename='app.log', # The file to log to
    level=logging.DEBUG, # The minimum level to log. If you omit this, the default level is WARNING
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', # The format of the log message
    datefmt='%d-%b-%y %H:%M:%S' # The format of the date
)
logger = logging.getLogger() # Get the root logger. You can also use `__name__` to get the logger of the current module but this creates issues when using multiple files.

# Log messages
logger.debug('This is a debug message')
logger.info('This is an info message')
logger.warning('This is a warning message')
logger.error('This is an error message')
logger.critical('This is a critical message')
```

**Output:**
```cmd
app.log
----------
25-May-21 15:58:58 - root - DEBUG - This is a debug message
25-May-21 15:58:58 - root - INFO - This is an info message
25-May-21 15:58:58 - root - WARNING - This is a warning message
25-May-21 15:58:58 - root - ERROR - This is an error message
25-May-21 15:58:58 - root - CRITICAL - This is a critical message
```

> **NOTE 2**: To change the contents and the format of the log message, see the [LogRecord Attributes].

> **NOTE 3**: By default the logger will append to the log file. If you want to overwrite the file each time you run the program, you can add `filemode='w'` to the `basicConfig` function.

<!-- TODO: Add logger inheritance section -->

<!-- links -->
[LogRecord Attributes]: https://docs.python.org/3/library/logging.html#logrecord-attributes