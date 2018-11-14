# dkst

Control Deckset through a simple CLI.

#### Installing:

```
git clone git@github.com:theolampert/dkst.git
cd dkst
swift build
```
Copy the built file to your PATH.

#### Using dkst:

```
Usage:

    $ dkst

Commands:

    + open - Open a Deckset presentation.
      <path> - Path to a Deckset presentation.
    + export - Export the current Deckset presentation.
      <path> - Path to a Deckset presentation.
      --format [PDF, JPEG, PNG] - Defaults to PDF.
      --printAllSteps - Defaults to false.
    + present - Present a Deckset presentation.
    + rehearse - Rehearse a Deckset presentation.
    + quit - Quit Deckset.
```
