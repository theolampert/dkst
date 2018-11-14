# dkst

Control Deckset through a simple CLI.

#### Installing:

```sh
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
