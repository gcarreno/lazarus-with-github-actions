# lazarus-with-github-actions

[![Actions Status](https://github.com/gcarreno/lazarus-with-github-actions/workflows/build-test/badge.svg)](https://github.com/gcarreno/lazarus-with-github-actions/actions)

Testing grounds for the GitHub action [setup-lazarus](https://github.com/gcarreno/setup-lazarus)

**Note**: For supported Lazarus versions and the associated FPC version consult the link above.

![setup-lazarus logo](https://github.com/gcarreno/setup-lazarus/blob/master/images/setup-lazarus-logo.png)

## VERY IMPORTANT NOTICE

> When build for the `Qt5` widgetset, the combination of `stable`/`v3.0` and `ubuntu-latest`/`ubuntu-22.04` is going to fail.
>
> This is why this example is failing when attempting the mentioned combination of widgetset, Lazarus version and Ubuntu version.
>
> This is due to the fact that `libqt5pas` is outdated and does not support the new code delivered by Lazarus 3.0.
>
> This is a problem related to the Ubuntu distribution's repositories and the version of `libqt5pas` they carry, used by the GitHub runners.
>
> According to the maintainer of said `libqt5pas`, in [this answer](https://forum.lazarus.freepascal.org/index.php/topic,65619.msg500216.html#msg500216), one solution is to have the workflow script download and install a newer version.
>
> The newer version can be obtained here: https://github.com/davidbannon/libqt5pas/releases
>
> Thank you for your patience, continued support and please accept my deepest apologies for this inconvenience.

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
