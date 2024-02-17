#!/usr/bin/env python3

# Outputs to 'output.txt' lines from 'input.txt' in the order they appear in 'order.txt'
# Skips lines which don't appear in 'order.txt'.

from sys import stdin
import sys


def simple_write_strings(filename, lst):
    with open(filename, 'w', encoding='utf-8') as out_file:
        out_file.write(('\n'.join(str(i) for i in lst)) + '\n')


def simple_read_strings(filename):
    with open(filename, encoding='utf-8') as in_file:
        return [line.rstrip() for line in in_file]


order = simple_read_strings('order.txt')
unordered = set(simple_read_strings('input.txt'))
reordered = []

for line in order:
    if line in unordered:
        reordered.append(line)

simple_write_strings('output.txt', reordered)
