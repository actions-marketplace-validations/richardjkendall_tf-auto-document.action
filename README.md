# tf-auto-document.action
A GitHub action to auto generate documentation for Terraform files.

This wraps up the tf-auto-document tool here: https://github.com/richardjkendall/tf-auto-document

See example of what the documentation looks like here: https://github.com/richardjkendall/tf-modules

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
    - name: build docs
      uses: richardjkendall/tf-auto-document.action@v0.01
    - name: commit doc changes
      run : |
        git_hash=$(git rev-parse --short "$GITHUB_SHA")
        git add **/*.md
        git config user.email "<email address>"
        git config user.name "Robot"
        git commit -m "docs for commit $git_hash"
        git push
```
