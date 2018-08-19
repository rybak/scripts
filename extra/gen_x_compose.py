#!/usr/bin/python3

#
# Copyright 2018 Andrei Rybak
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

import unicodedata
import sys

#
# Helper script to generate XCompose files
#
# Usage:
#
#   ./gen_x_compose.py >Compose
#
# Output in file 'Compose' then has to be manually adjusted
#
# How to use XCompose instructions on askubuntu.com:
# https://askubuntu.com/a/877344/99330
#
# See Wikipedia page about Unicode block:
# https://en.wikipedia.org/wiki/Greek_and_Coptic
#

# 25 and not 24 (the size of Greek alphabet) to cover hole in Unicode block
# Set this variable to 27 to cover even more letters
size = 25

def debug(x):
    print(x, file=sys.stderr)

def print_alphabet(starter, latin_start, greek_start):
    for i in range(0, size):
        latin_letter = chr(latin_start + i)
        greek_letter = chr(greek_start + i)
        debug("g + " + latin_letter + "=" + greek_letter +
                "\tU{:04X}".format(ord(greek_letter)))
        try:
            comment = unicodedata.name(greek_letter)
            print("<Multi_key> <{}> <{}> : \"{}\"    U{:04X}    # {}".format(
                starter,
                latin_letter,
                greek_letter,
                ord(greek_letter),
                comment
                ))
        except:
            # undefined Unicode code point
            debug("Skipping...")
            pass


ALPHA = 0x0391 # CAPITAL ALPHA code point
print_alphabet('G', ord('A'), ALPHA)
alpha = ord(u'α')
print_alphabet('g', ord('a'), alpha)

