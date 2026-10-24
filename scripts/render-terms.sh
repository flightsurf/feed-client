#!/bin/bash
# Render the headings, links, emphasis and bullets used in TERMS.md as plain text.
# Keep TERMS.md as the single source of the terms' wording.
set -euo pipefail

printf '%s\n\n' 'Use Up/Down or Page Up/Page Down to read.' \
    'Press Tab to select Continue, then Enter.'

sed -E \
    -e 's/^#{1,6} //' \
    -e 's/\[([^]]+)\]\(([^)]+)\)/\1: \2/g' \
    -e 's/\*\*//g' \
    -e 's/`//g' "$1" |
    awk '
    function wrap(text, prefix, continuation,    count, words, i, line) {
        count = split(text, words, /[[:space:]]+/)
        line = prefix
        for (i = 1; i <= count; i++) {
            if (length(line) > length(prefix) && length(line) + 1 + length(words[i]) > 70) {
                print line
                line = continuation
                prefix = continuation
            }
            if (length(line) > length(prefix)) line = line " "
            line = line words[i]
        }
        print line
    }
    /^- / {
        if (bullet) print ""
        wrap(substr($0, 3), "- ", "  ")
        bullet = 1
        next
    }
    {
        bullet = 0
        wrap($0, "", "")
    }'
