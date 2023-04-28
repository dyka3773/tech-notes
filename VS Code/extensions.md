# Useful VS Code Extensions

## Table of Contents
- [Useful VS Code Extensions](#useful-vs-code-extensions)
  - [Table of Contents](#table-of-contents)
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