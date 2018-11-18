# dkst [![Build Status](https://travis-ci.org/theolampert/dkst.svg?branch=master)](https://travis-ci.org/theolampert/dkst)

Control Deckset through a simple CLI.

#### Installing:

##### Get latest binary:

```
curl -L https://github.com/theolampert/dkst/releases/download/v1.0.2/dkst > dkst
chmod +x dkst
./dkst
```
Copy the file to somewhere in your PATH.

##### Build from source:
```sh
git clone git@github.com:theolampert/dkst.git
cd dkst
swift build -c release
```

Copy `.build/release/dkst` to somewhere in your PATH.

#### Using dkst:

```
Usage:

    $ dkst

Commands:

    + export - Export the current Deckset presentation.
      <path> - Path to a Deckset presentation.
      --format [PDF, JPEG, PNG] - Defaults to PDF.
      --printAllSteps - Defaults to false.
    + present - Present a Deckset presentation.
    + rehearse - Rehearse a Deckset presentation.
    + open - Open a Deckset presentation.
      <path> - Path to a Deckset presentation.
    + preview - Toggle the Deckset preview window.
    + quit - Quit Deckset.
```
