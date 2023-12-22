# lazarus-with-github-actions

[![Actions Status](https://github.com/gcarreno/lazarus-with-github-actions/workflows/build-test/badge.svg)](https://github.com/gcarreno/lazarus-with-github-actions/actions)

Testing grounds for the GitHub action [setup-lazarus](https://github.com/gcarreno/setup-lazarus)

**Note**: For supported Lazarus versions and the associated FPC version consult the link above.

![setup-lazarus logo](https://github.com/gcarreno/setup-lazarus/blob/master/images/setup-lazarus-logo.png)

## Example usage

```yaml
steps:
- uses: actions/checkout@v4
- uses: gcarreno/setup-lazarus@v3
  with:
    lazarus-version: "dist"
    include-packages: "Synapse 40.1"
    with-cache: true
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
    - uses: actions/checkout@v4
    - name: Install Lazarus
      uses: gcarreno/setup-lazarus@v3
      with:
        lazarus-version: ${{ matrix.lazarus-versions }}
        include-packages: "Synapse 40.1"
        with-cache: true
    - name: Build the Main Application (Windows)
      if: ${{ matrix.operating-system == 'windows-latest' }}
      run: lazbuild -B --bm=Release "src/lazaruswithgithubactions.lpi"
    - name: Build the Main Application (Ubuntu)
      if: ${{ matrix.operating-system == 'ubuntu-latest' }}
      run: |
        echo Building with GTK2
        lazbuild -B --bm=Release "src/lazaruswithgithubactions.lpi"
        echo Installing Qt5 Dev
        sudo apt update
        sudo apt install libqt5pas-dev -y
        echo Building with Qt5
        lazbuild -B --bm=Release --ws=qt5 "src/lazaruswithgithubactions.lpi"
    - name: Build the Main Application (macOS)
      if: ${{ matrix.operating-system == 'macos-latest' }}
      run: lazbuild -B --bm=Release --ws=cocoa "src/lazaruswithgithubactions.lpi"
    - name: Build the Unit Tests Application
      run: lazbuild -B --bm=Release "tests/testconsoleapplication.lpi"
    - name: Run the Unit Tests Application
      run: bin/testconsoleapplication "--all" "--format=plain"
```
