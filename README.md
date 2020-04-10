# lazarus-with-github-actions

[![Actions Status](https://github.com/gcarreno/lazarus-with-github-actions/workflows/build-test/badge.svg)](https://github.com/gcarreno/lazarus-with-github-actions/actions)

Testing grounds for the GitHub action [setup-lazarus](https://github.com/gcarreno/setup-lazarus)

**Note**: For supported Lazarus versions and the associated FPC version consult the link above.

![setup-lazarus logo](https://github.com/gcarreno/setup-lazarus/blob/master/images/setup-lazarus-logo.png)

## Example usage

```yaml
steps:
- uses: actions/checkout@v2
- uses: gcarreno/setup-lazarus@v2.1
  with:
    lazarus-version: 'dist'
- run: lazbuild YourTestProject.lpi
- run: YourTestProject
```

## Matrix example usage

```yaml
name: build

on:
  pull_request:
  push:
    paths-ignore:
    - "README.md"
    branches:
      - master
      - releases/*

jobs:
  build:
    runs-on: ${{ matrix.operating-system }}
    strategy:
      matrix:
        operating-system: [ubuntu-18.04,ubuntu-latest]
        lazarus-versions: [dist, 2.0.6]
    steps:
    - uses: actions/checkout@v2
    - name: Install Lazarus
      uses: gcarreno/setup-lazarus@v2.1
      with:
        lazarus-version: ${{ matrix.lazarus-versions }}
    - name: Build the test app
      run: lazbuild "tests/testconsoleapplication.lpi"
    - name: Run the test app
      run: bin/testconsoleapplication "--all" "--format=plain"
```
