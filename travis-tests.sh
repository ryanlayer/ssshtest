#!/bin/bash

test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest

. ssshtest

STOP_ON_FAIL=0

run test_in_stdout python -c "print 'example assert_in_stdout success'"
assert_in_stdout "example"

run test_in_stderr python -c "import sys; sys.stderr.write('example assert_in_stdout failure')"
assert_in_stderr "example"

run test_in_stderr python -c "import sys; sys.stderr.write('example assert_in_stderr success')"
assert_in_stderr "example" 


run test_stdout python -c "print 'example assert_stdout success'"
assert_stdout 

run test_stderr python -c "import sys; sys.stderr.write('example assert_stderr success')"
assert_stderr 

run test_no_stdout python -c "import sys; sys.stderr.write('example assert_no_stdout success')"
assert_no_stdout 

run test_no_stdout python -c "import sys; sys.stderr.write('example')"
assert_no_stdout 

run test_no_stderr python -c "print 'example assert_no_stderr success'"
assert_no_stderr 

run test_no_stderr python -c "import sys; sys.stdout.write('example assert_no_stderr failure')"
assert_no_stderr 
