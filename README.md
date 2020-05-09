# tf-auto-document.action
A GitHub action to auto generate documentation for Terraform files.

This wraps up the tf-auto-document tool here: https://github.com/richardjkendall/tf-auto-document

See example of what the documentation looks like here: https://github.com/richardjkendall/tf-modules

## Requirements

Expects the target repository be structured as follows

```
root
 |-modules
    |-module1
    |-module2
    |-module...
```

The modules sub-folder can be renamed and the name of this folder can be passed into the action using the ``modulesFolder`` input variable.

For more info about the tool and how it works, look here https://github.com/richardjkendall/tf-auto-document

## Special Git Requirements

Normally when you use the action/checkout action in a workflow it does a shallow clone of the your repository and does not pull any tags down.  The full history and tags are needed so that the tool can find the releases to include in the documentation.

To do this there are two steps needed:

1. on the checkout action add 

```
with:
  fetch-depth: 0
```

2. add a step right after the checkout action which pulls down the tags

```
- name: get all tags
  run: git fetch origin +refs/tags/*:refs/tags/*
```

## Example

```yaml
name: build docs
on:
  push:
    branches: [ master ]
    paths:
      - '**.tf'

jobs:
  build:
    name: build docs
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
      with:
        fetch-depth: 0
    - name: get all tags
      run: git fetch origin +refs/tags/*:refs/tags/*
    - name: build docs
      uses: richardjkendall/tf-auto-document.action@v0.05
      with:
        modulesFolder: 'modules'
    - name: commit doc changes
      run : |
        git_hash=$(git rev-parse --short "$GITHUB_SHA")
        git add **/*.md
        git config user.email <email address>
        git config user.name "Robot"
        git commit -m "docs for commit $git_hash"
        git push
```
