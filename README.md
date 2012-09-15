# imgsize README

imgsize will show you the size of an image.

### -r will give you the 'raw' numbers

	imgsize.sh -r foo.jpg
	720 384

Note: *Currently* the default (if you do not give any arguments) is the same as if you give -r ("raw") ***but that may change in the future*** so if you rely on that output, invoke it explicitly using `-r`

### -x will give you the same thing but with an 'x' instead of a space

	imgsize.sh -x foo.jpg
	720x384

### -W will give you just the width (note: must be capitalized)

	imgsize.sh -W foo.jpg
	720

### -H will give you just the height (note: must be capitalized)

	imgsize.sh -H foo.jpg
	384

### -h will give you HTML

	imgsize.sh -h foo.jpg
	<img alt='[image]' src="foo.jpg" width="720" height="384" border="0" />

### -m will give you Markdown

	imgsize.sh -m foo.jpg
	![](foo.jpg)

### -a will give you perl

	imgsize.sh -a foo.jpg
	(-width => 720, -height => 384)

*note: I don't speak `perl` but I saw another version of `imgsize` which formatted it this way so I'm duplicating it.*

## Bugs and Disclaimers

This script is not intended to be brilliant. It is intended to work most of the time. It relies on `sips` on Mac OS X. If you run it on a non-image file, it will get confused and keep trying to get the image size, and you will have to tell it to stop using Control+C.
