**Table of Contents**
- [Categories](#categories)
  - [Extensions for Specific Languages](#extensions-for-specific-languages)
      - [Python](#python)
      - [NodeJS](#nodejs)
      - [Powershell](#powershell)
  - [Extensions for DBMSs](#extensions-for-dbmss)
      - [MySQL](#mysql)
      - [Oracle](#oracle)
      - [Other](#other)
  - [Extensions for Git](#extensions-for-git)
  - [Web Development Extensions](#web-development-extensions)
  - [Data MarkUp or Markdown Extensions](#data-markup-or-markdown-extensions)
  - [Misc Extensions](#misc-extensions)
- [Extensions](#extensions)
  - [Todo Tree *(ID: Gruntfuggly.todo-tree)*](#todo-tree-id-gruntfugglytodo-tree)
      - [Settings Example](#settings-example)
  - [Markdown All in One *(ID: yzhang.markdown-all-in-one)*](#markdown-all-in-one-id-yzhangmarkdown-all-in-one)
  - [Oracle Developer Tools for VS Code *(ID: Oracle.oracledevtools)*](#oracle-developer-tools-for-vs-code-id-oracleoracledevtools)
  - [REST Client *(ID: humao.rest-client)*](#rest-client-id-humaorest-client)
  - [GitLens *(ID: eamodio.gitlens)*](#gitlens-id-eamodiogitlens)
  - [Git Graph *(ID: mhutchie.git-graph)*](#git-graph-id-mhutchiegit-graph)
  - [Beautify *(ID: HookyQR.beautify)*](#beautify-id-hookyqrbeautify)
  - [EJS Language Support *(ID: DigitalBrainstem.javascript-ejs-support)*](#ejs-language-support-id-digitalbrainstemjavascript-ejs-support)
  - [GitHub Copilot *(ID: GitHub.copilot)*](#github-copilot-id-githubcopilot)
  - [GitHub Copilot Labs *(ID: GitHub.copilot-labs)*](#github-copilot-labs-id-githubcopilot-labs)
  - [learn-yaml *(ID: docsmsft.docs-yaml)*](#learn-yaml-id-docsmsftdocs-yaml)
  - [Path Intellisense *(ID: christian-kohler.path-intellisense)*](#path-intellisense-id-christian-kohlerpath-intellisense)
  - [Powershell *(ID: ms-vscode.powershell)*](#powershell-id-ms-vscodepowershell)
  - [Remote Explorer *(ID: ms-vscode-remote.remote-explorer)*](#remote-explorer-id-ms-vscode-remoteremote-explorer)
  - [SQL Beautify *(ID: clarkyu.vscode-sql-beautify)*](#sql-beautify-id-clarkyuvscode-sql-beautify)
  - [WSL *(ID: ms-vscode-remote.remote-wsl)*](#wsl-id-ms-vscode-remoteremote-wsl)
  - [YAML *(ID: redhat.vscode-yaml)*](#yaml-id-redhatvscode-yaml)
  - [XML *(ID: redhat.vscode-xml)*](#xml-id-redhatvscode-xml)
  - [MySQL *(ID: formulahendry.vscode-mysql)*](#mysql-id-formulahendryvscode-mysql)
  - [Python *(ID: ms-python.python)*](#python-id-ms-pythonpython)
  - [autoDocstring *(ID: njpwerner.autodocstring)*](#autodocstring-id-njpwernerautodocstring)
  - [Jinja *(ID: wholroyd.jinja)*](#jinja-id-wholroydjinja)
  - [Django *(ID: batisteo.vscode-django)*](#django-id-batisteovscode-django)
  - [Jupyter *(ID: ms-toolsai.jupyter)*](#jupyter-id-ms-toolsaijupyter)
  - [Python Environment Manager *(ID: donjayamanne.python-environment-manager)*](#python-environment-manager-id-donjayamannepython-environment-manager)


# Categories

## Extensions for Specific Languages

#### Python

- [Python](#python-id-ms-pythonpython)
- [autoDocstring](#autodocstring-id-njpwernerautodocstring)
- [Jinja](#jinja-id-wholroydjinja)
- [Django](#django-id-batisteovscode-django)
- [Jupyter](#jupyter-id-ms-toolsaijupyter)
- [Python Environment Manager](#python-environment-manager-id-donjayamannepython-environment-manager)

#### NodeJS

- [EJS Language Support](#ejs-language-support-id-digitalbrainstemjavascript-ejs-support)

#### Powershell

- [Powershell](#powershell-id-ms-vscodepowershell)

## Extensions for DBMSs

#### MySQL

- [MySQL](#mysql-id-formulahendryvscode-mysql)

#### Oracle

- [Oracle Dev Tools](#oracle-developer-tools-for-vs-code-id-oracleoracledevtools)

#### Other

- [SQL Beautify](#sql-beautify-id-clarkyuvscode-sql-beautify)

## Extensions for Git

- [GitLens](#gitlens-id-eamodiogitlens)
- [Git Graph](#git-graph-id-mhutchiegit-graph)

## Web Development Extensions

- [REST Client](#rest-client-id-humaorest-client)

## Data MarkUp or Markdown Extensions

- [learn-yaml](#learn-yaml-id-docsmsftdocs-yaml)
- [YAML](#yaml-id-redhatvscode-yaml)
- [XML](#xml-id-redhatvscode-xml)
- [Markdown All in One](#markdown-all-in-one-id-yzhangmarkdown-all-in-one)

## Misc Extensions

- [Todo Tree](#todo-tree-id-gruntfugglytodo-tree)
- [GitHub Copilot](#github-copilot-id-githubcopilot)
- [GitHub Copilot Labs](#github-copilot-labs-id-githubcopilot-labs)
- [Beautify](#beautify-id-hookyqrbeautify)
- [Path Intellisense](#path-intellisense-id-christian-kohlerpath-intellisense)
- [Remote Explorer](#remote-explorer-id-ms-vscode-remoteremote-explorer)
- [WSL](#wsl-id-ms-vscode-remoteremote-wsl)


# Extensions

## Todo Tree *(ID: Gruntfuggly.todo-tree)*

- This extension allows you to create TODOs in your code and then view them in a tree view. 
- It supports a variety of languages and allows you to customize the regex used to find TODOs.
- It also supports a variety of themes and allows you to customize the colors used to display TODOs and other tags.

#### Settings Example

```json
"todo-tree.general.statusBar": "current file",
    "todo-tree.general.showActivityBarBadge": true,
    "todo-tree.filtering.excludeGlobs": [
        "**/node_modules/*/**",
        "**/*env/**",
        "**/temp/**"
    ],
    "todo-tree.general.tagGroups": {
    
        "TODO": ["TODO", "[ ]", "[-]"],
        "NOTE": ["NOTE", "INFO"],
        "FIXME": ["FIXME", "FIXIT", "FIXTHIS"]
    },
    "todo-tree.general.tags": [
        "BUG",
        "HACK",
        "FIXME",
        "FIXIT",
        "FIXTHIS",
        "XXX",
        "NOTE",
        "INFO",
        "TODO",
        "[ ]",
        "[-]",
    ],
    "todo-tree.highlights.customHighlight": {

        "BUG": {
            "icon": "bug"
        },
        "HACK": {
            "icon": "alert"
        },
        "FIXME": {
            "icon": "tools"
        },
        "XXX": {
            "icon": "x"
        },
        "NOTE": {
            "icon": "note"
        },
        "TODO":{
            "icon": "issue-draft"
        }
    },
    "todo-tree.highlights.useColourScheme": true,
    "todo-tree.general.showIconsInsteadOfTagsInStatusBar": true
```


## Markdown All in One *(ID: yzhang.markdown-all-in-one)*

- This extension provides a variety of useful features for working with Markdown files.
- It supports a variety of keyboard shortcuts for common Markdown actions.
- It also supports linting and table of contents generation.


## Oracle Developer Tools for VS Code *(ID: Oracle.oracledevtools)*

- This extension provides a variety of useful features for working with Oracle databases.
- It basically provides all the common features of SQL Developer in VS Code.
- Multiple connections can be configured and used at the same time.
- It supports a variety of keyboard shortcuts for common SQL actions.


## REST Client *(ID: humao.rest-client)*

- This extension allows you to send HTTP requests from VS Code.
- It supports a variety of HTTP methods and allows you to customize the request headers and body.
- You can save requests in a file and then run them from the file.
- It basically provides all the common features of Postman in VS Code.


## GitLens *(ID: eamodio.gitlens)*

- This extension provides a variety of useful features for working with Git.
- I mostly use it to view the Git history of a file and to view the Git blame of a file.


## Git Graph *(ID: mhutchie.git-graph)*

- This is a lightweight extension that provides a visual representation of the Git history of a repository.


## Beautify *(ID: HookyQR.beautify)*

- This extension is deprecated but I still use it because it works well for me.
- It allows you to format a variety of file types, namely `javascript`, `JSON`, `CSS`, `Sass`, and `HTML`.


## EJS Language Support *(ID: DigitalBrainstem.javascript-ejs-support)*

- This extension provides syntax highlighting for EJS files.


## GitHub Copilot *(ID: GitHub.copilot)*

- This extension provides AI-powered code suggestions.
- It actually works pretty well and I use it a lot.
- It is currently writing this README for me. 😄


## GitHub Copilot Labs *(ID: GitHub.copilot-labs)*

- This extension requires you to sign up for the GitHub Copilot Labs program and have GitHub Copilot installed.
- It provides a variety of experimental features for GitHub Copilot like:
  - code explanations
  - language translations between different programming languages (mainly JavaScript and Python)
  - test generation
  - code brushes (you select a piece of code and then use a brush to change it to a different piece of code that is bug-free, more efficient, more readable, etc.)


## learn-yaml *(ID: docsmsft.docs-yaml)*

- This extension is particularly useful for learning how to write YAML files.
- It offers validation, hover help, and completion for YAML files.


## Path Intellisense *(ID: christian-kohler.path-intellisense)*

- This extension provides auto-completion for file paths.
- It also supports auto-completion for `import` statements in some languages.


## Powershell *(ID: ms-vscode.powershell)*

- This extension provides a variety of useful features for working with PowerShell.
- It provides syntax highlighting, code snippets, and debug support.


## Remote Explorer *(ID: ms-vscode-remote.remote-explorer)*

- This extension provides useful features for working with remote files and folders through SSH.
- It allows you to connect to a remote server and then browse the files and folders on that server.
- It also allows you to use shell commands on that workspace as if it were a local workspace.


## SQL Beautify *(ID: clarkyu.vscode-sql-beautify)*

- This extension provides formatting for SQL files.
- It supports a variety of formatting options and allows you to customize the formatting rules.


## WSL *(ID: ms-vscode-remote.remote-wsl)*

- This extension provides useful features for working with WSL.
- It allows you to connect to a WSL instance and then browse the files and folders on that instance.
- This way you can use VS Code to edit and run scripts on your WSL instance.


## YAML *(ID: redhat.vscode-yaml)*

- This extension provides language support for YAML files.


## XML *(ID: redhat.vscode-xml)*

- This extension provides language support for XML files.


## MySQL *(ID: formulahendry.vscode-mysql)*

- This extension provides a variety of useful features for working with MySQL databases.
- It provides syntax highlighting, code snippets, and debug support.
- It basically provides all the common features of MySQL Workbench in VS Code.


## Python *(ID: ms-python.python)*

- This is a pack of extensions that provide language support for Python.
- It provides syntax highlighting, code snippets, debug support and a Python interactive window.


## autoDocstring *(ID: njpwerner.autodocstring)*

- This extension is particularly useful for writing docstrings for Python functions.


## Jinja *(ID: wholroyd.jinja)*

- This extension provides language support for the Jinja templating language.
- It provides syntax highlighting and code snippets.


## Django *(ID: batisteo.vscode-django)*

- This extension provides a variety of useful features for working with Django projects.
- It provides syntax highlighting, code snippets, and debug support.


## Jupyter *(ID: ms-toolsai.jupyter)*

- This is a pack of extensions that provide a variety of useful features for working with Jupyter notebooks.
- They provide syntax highlighting, code snippets, debug support and interactive Jupyter notebooks.


## Python Environment Manager *(ID: donjayamanne.python-environment-manager)*

- This extension allows you to manage Python environments.
- This is quite useful when you have multiple Python projects that use different versions of Python and different Python packages.