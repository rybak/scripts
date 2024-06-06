#!/usr/bin/env python3

from sys import stdin
# Only in python 3.12: from itertools import batched
import requests
import time
import sys


# the separator and the limit are documented here:
#     https://en.wikipedia.org/w/api.php?action=help&modules=query%2Busers
USERNAMES_SEPARATOR = '|'
LIST_USERS_LIMIT = 50
API_BASE_URL = 'https://en.wikipedia.org/w/api.php'
# https://stackoverflow.com/a/16549381/1083697
sys.stdin.reconfigure(encoding='utf-8')


def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]


def batch_to_ususers(batch):
    return USERNAMES_SEPARATOR.join(batch)


def simple_write_strings(filename, lst):
    with open(filename, 'w', encoding='utf-8') as outfile:
        outfile.write(('\n'.join(str(i) for i in lst)) + '\n')


def try_n_times(n, f):
    try_count = 0
    delay_seconds = 5
    while try_count < n:
        try:
            try_count = try_count + 1
            return f()
        except Exception as e:
            print('FAILED', e)
            print('sleeping for', delay_seconds, 'seconds')
            time.sleep(delay_seconds)
            delay_seconds = delay_seconds * 2
    sys.exit(1)


usernames = []

for line in stdin:
    usernames.append(line.rstrip())

edit_counts = {}
registrations = {}

for batch in chunks(usernames, LIST_USERS_LIMIT):
    # Example: https://en.wikipedia.org/w/api.php?action=query&list=users&ususers=Example|ZARDIAZ|Zarina%206022|Zatrp&usprop=editcount|registration&format=json
    ususers = batch_to_ususers(batch)
    print(ususers)
    params = {
            'action':'query',
            'list':'users',
            'format':'json',
            'usprop':'editcount|registration',
            'ususers': ususers
            }
    try:
        response = try_n_times(5, lambda: requests.get(API_BASE_URL, params, timeout=10)).json()
        users = response['query']['users']
        for user in users:
            if 'editcount' in user:
                edit_counts[user['name']] = user['editcount']
            else:
                print('beware', user['name'])
            if 'registration' in user and user['registration'] is not None:
                # save only the year of the registration timestamp
                registrations[user['name']] = user['registration'][:4]
        time.sleep(2)
    except Exception as e:
        print('Unexpected exception', e)
        sys.exit(2)


zeros = []
nonzeros = []
weird = []

for username in usernames:
    if username in edit_counts:
        if edit_counts[username] == 0:
            zeros.append(username)
        else:
            nonzeros.append(username)
    else:
        print('ACHTUNG', username)
        weird.append(username)
        nonzeros.append(username)


simple_write_strings('/tmp/zeros.txt', zeros)
simple_write_strings('/tmp/nonzeros.txt', nonzeros)
simple_write_strings('/tmp/weird.txt', weird)
csv_strings = [','.join([username, str(ec), str(registrations.get(username))]) for username, ec in edit_counts.items()]
simple_write_strings('/tmp/Username_EditCount_RegistrationYear.csv', csv_strings)
