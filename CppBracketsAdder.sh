#!/bin/sh

if [ "$#" -ne 1 ] || ! [ -d "$1" ]; then
  echo "Usage: $0 DIRECTORY" >&2
  exit 1
fi

# "if", "else if" with or without newline, no internal ()
find $1 -name "*.*pp" | xargs perl -i -0pe 's/([\n])( *)([else ]*if\s*\([^\(^\)]*\))\s*[\n]*\s*([^\/\{\n]*;)([\n])/$1$2$3\n$2\{\n$2  $4\n$2\}$5/g'

# "for" with or without newline, no internal ()
find $1 -name "*.*pp" | xargs perl -i -0pe 's/([\n])( *)(for\s*\([^\(^\)]*\))\s*[\n]*\s*(.*;)([\n])/$1$2$3\n$2\{\n$2  $4\n$2\}$5/g'

# "else" with or without newline
find $1 -name "*.*pp" | xargs perl -i -0pe 's/([\n])( *)(else)\s*[\n]*\s*(.*;)([\n])/$1$2$3\n$2\{\n$2  $4\n$2\}$5/g'

# "if", "else if" with new line, handles internal ()
find $1 -name "*.*pp" | xargs perl -i -0pe 's/([\n])( *)([else ]*if\s*\(.*\)\s*\n)\s*[\n]*\s*([^\{;|]*;)([\n])/$1$2$3$2\{\n$2  $4\n$2\}$5/g'
