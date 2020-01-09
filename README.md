# highlights-to-markdown

![Swift 5.1](https://img.shields.io/badge/swift-5.1-orange.svg) ![Supported Platforms: macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)

Extracts highlight annotations from a PDF file and prints them as Markdown quotes.

The implementation is cross-platform but the `h2m` executable is macOS-only.

## Usage

```sh
swift run h2m $PDF_PATH
```

or after installing somewhere in your $PATH:

```sh
h2m $PDF_PATH
```

## Example Output

```md
# Objectives and constraints

> You realize that things that seem grossly subopitmal are actually close to optimal when you consider the necessary constraints.
– Page 1

> If I ask “Why hasn’t someone done this before?” I’m skeptical if the answer is “Because I’m smarter than everyone else who has tried.” But if the answer is “Because constraints have changed” then I’m much more receptive.
– Page 2
```

## Installation

### Homebrew

`brew install interstateone/formulae/highlights-to-markdown`

### Manually

```sh
git clone https://github.com/interstateone/highlights-to-markdown.git
cd highlights-to-markdown
make install
```

```sh
swift build -c release
cp `swift build -c release --show-bin-path`/h2m $DESTINATION
```

## Finder Integration

Create a Quick Action in Automator and invoke h2m with Applescript:

```applescript
on run {input, parameters}
	set pdf to POSIX path of input
	set markdown to (do shell script "/path/to/h2m '" & pdf & "'")
	set the clipboard to markdown
end run
```
