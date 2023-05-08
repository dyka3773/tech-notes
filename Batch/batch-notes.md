## Waiting for user input to continue the flow of the program

```cmd
@REM Case 1
PAUSE

@REM Case 2
TIMEOUT /t -1
```
Both of the above commands will wait by printing the message *`Press any key to continue . . .`* and waiting for the user to press any key to continue the flow of the program .
The difference is that `TIMEOUT` can take more than one argument. For example, `TIMEOUT /t 5` will wait for 5 seconds before continuing the flow of the program.

> See also: [TIMEOUT][1], [PAUSE][2]

## Getting the parent directory of the batch file being executed

> The equivalent of `dirname` in bash

```cmd
ECHO %~dp0
```
`%0` contains the full path of the running `.bat` or `.cmd` file.

The `~` expansions can be applied to all numbered arguments (`%0`…`%9`) and to the one-letter variables used by `FOR` (e.g. `%%a`). The most commonly used expansions are:

- `~d`: drive letter (with colon)
- `~p`: directory path (without drive letter)
- `~n`: file name without extension
- `~x`: file extension (with leading dot)

So combining them into `%~dp0` will work like `dirname`, while `%~nx0` will work like `basename`.

## Open a new command prompt window

`START` will instantiate a new `CMD.exe` shell for the called batch. This will inherit variables from the calling shell, but any variable changes will be discarded when the second script ends.

```cmd
@REM This opens a new command prompt window and continues the execution of the batch file
start cmd.exe

@REM This opens a new command prompt window named "My terminal", which prints "Hello World" and remains open while the calling batch file has continued its execution
start "My terminal" cmd.exe /k "echo Hello World"

@REM Real life example
START "Kafka Schema Registry" wsl docker-compose up
```
> **NOTE**: `start` searches for a specified executable file, and if found the executable will launch regardless of the current working directory. When searching for an executable file, if there's no match on any extension, `start` checks to see if the name matches a directory name. If it does, `start` opens `Explorer.exe` on that path.

> See also: [Microsoft][4], [SS64][3] Docs for `START` command

## `START` vs `CALL`

There is also a command called `CALL` which is used to execute another batch file. The main difference between `CALL` and `START` is that `CALL` will execute the batch file in the same shell, while `START` will execute the batch file in a new shell. This also means that the calling batch file will wait for the called batch file to finish before continuing its execution.

A way to think about it is that `CALL` is like a function call, while `START` is like a new process. 
> In fact, `CALL` can be used to call labels in the same batch file like `GOTO`, while `START` can only be used to call other batch files.

The way to make `START` work almost like `CALL` is to use `/w /b` switches, which will make `START` execute the batch file in the same shell and wait for it to finish before continuing the execution of the calling batch file.

> See also: [SS64][5], [Microsoft][6] Docs for `CALL` command

## FOR loops

TODO: Add notes on how FOR loops work [Help](https://ss64.com/nt/for.html)

TODO: Add notes on how to use FOR /F to read from a file [Help](https://ss64.com/nt/for_f.html)

## References
- bat vs cmd: https://stackoverflow.com/questions/148968/windows-batch-files-bat-vs-cmd
- [TIMEOUT][1] Command
- [PAUSE][2] Command
- [START][4] Command
- [CALL][6] Command


[1]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/timeout
[2]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/pause
[3]: https://ss64.com/nt/start.html
[4]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/start
[5]: https://ss64.com/nt/call.html
[6]: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/call