# lazarus-with-github-actions

[![Actions Status](https://github.com/gcarreno/lazarus-with-github-actions/workflows/build-test/badge.svg)](https://github.com/gcarreno/lazarus-with-github-actions/actions)

Testing grounds for the GitHub action [setup-lazarus](https://github.com/gcarreno/setup-lazarus)

**Note**: For supported Lazarus versions and the associated FPC version consult the link above.

![setup-lazarus logo](https://github.com/gcarreno/setup-lazarus/blob/master/images/setup-lazarus-logo.png)

## Example usage

```yaml
steps:
- uses: actions/checkout@v2
- uses: gcarreno/setup-lazarus@v3.0.9
  with:
    lazarus-version: "dist"
    include-packages: "Synapse 40.1"
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
        lazarus-versions: [dist, stable, 2.0.12, 2.0.10]
    steps:
    - uses: actions/checkout@v2
    - name: Install Lazarus
      uses: gcarreno/setup-lazarus@v3.0.9
      with:
        lazarus-version: ${{ matrix.lazarus-versions }}
        include-packages: "Synapse 40.1"
    - name: Build the Main Application
      if: ${{ matrix.operating-system != 'macos-latest' }}
      run: lazbuild -B "src/lazaruswithgithubactions.lpi"
    - name: Build the Main Application (macOS)
      if: ${{ matrix.operating-system == 'macos-latest' }}
      run: lazbuild -B --ws=cocoa "src/lazaruswithgithubactions.lpi"
    - name: Build the Unit Tests Application
      run: lazbuild -B "tests/testconsoleapplication.lpi"
    - name: Run the Unit Tests Application
      run: bin/testconsoleapplication "--all" "--format=plain"
```
