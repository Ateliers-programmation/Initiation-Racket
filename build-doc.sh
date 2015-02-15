#!/bin/sh
pandoc --from=markdown_github --to=html5 introduction.md \
    --highlight-style pygments --table-of-contents --standalone \
    --output=intro.html

