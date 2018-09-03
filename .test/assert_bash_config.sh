#!/bin/bash

. .test/assert/assert.sh

# Sourcing the following files should return 0
assert_raises "source .bashrc" 0
assert_raises "source .bash.alias" 0

# ... they should also output nothing ...
assert "source .bashrc 2>&1" ""
assert "source .bash.alias 2>&1" ""

# end of test suite
assert_end examples

