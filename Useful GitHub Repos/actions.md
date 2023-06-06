<!-- omit in toc -->
# Useful GitHub Actions

<!-- omit in toc -->
## Table of Contents

- [Markdown link checker](#markdown-link-checker)


## Markdown link checker

Link: [Here](https://github.com/gaurav-nelson/github-action-markdown-link-check)

Description: A GitHub Action to check for broken links in Markdown files.

<!-- omit in toc -->
### Sample usage:

```yml
name: Check Markdown links

on: push

jobs:
  markdown-link-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: gaurav-nelson/github-action-markdown-link-check@v1
```