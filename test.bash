#!/bin/bash -ex

trap "echo -e '\x1b[01;31mFailed\x1b[0m'" ERR

python -m yolk --query-metadata=pip | grep -i 'license:'
python -m yolk --query-metadata=pip --fields=author,name | grep -i 'author:'
python -m yolk --query-metadata=pip --fields=author,name | grep -i 'license:' && exit 1

# Do not print field name if there is only one.
python -m yolk --query-metadata=pip --fields=author | grep -i 'author:' && exit 1
python -m yolk --depends=pip
python -m yolk --list
python -m yolk --list pip
python -m yolk --list --metadata pip | grep -i 'license:'
python -m yolk --list --metadata --fields=author,license | grep -i 'author:'
python -m yolk --list --metadata --fields=author,license | grep -i 'license:'

python -m yolk --depends=fake_foo 2>&1 | grep 'fake_foo is not installed'

# not supported
#python -m yolk --latest-releases=1
# overwhelming server
#python -m yolk --show-updates
#python -m yolk --show-updates --user

python -m doctest yolk/utils.py

echo -e '\x1b[01;32mOkay\x1b[0m'
