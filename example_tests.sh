#!/bin/bash

test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest

source ssshtest

STOP_ON_FAIL=0

#--- assert_in_stdout
# Success
run test_in_stdout python -c "print 'example assert_in_stdout success'"
assert_in_stdout "example"

# Fails because there is nothing in stdout
run test_in_stdout python -c "import sys; sys.stderr.write('example assert_in_stdout failure')"
assert_in_stdout "example"

# Fails because "simple test" is not in stdout
run test_in_stdout python -c "print 'example assert_in_stdout success'"
assert_in_stdout "simple test"


#--- assert_in_stderr
# Success
run test_in_stderr python -c "import sys; sys.stderr.write('example assert_in_stderr success')"
assert_in_stderr "example" 

# Fails because there is nothing in stderr
run test_in_stderr python -c "print 'example assert_in_stderr failure'"
assert_in_stderr "example" 

# Fails because "simple test" is not in stderr
run test_in_stderr python -c "import sys; sys.stderr.write('example assert_in_stderr success')"
assert_in_stderr "simple test" 

#--- assert_stdout
# Success
run test_stdout python -c "print 'example assert_stdout success'"
assert_stdout 

# Fails because there is nothing in stdout
run test_stdout python -c "import sys; sys.stderr.write('example assert_stdout failure')"
assert_stdout 

#--- assert_stderr
# Success
run test_stderr python -c "import sys; sys.stderr.write('example assert_stderr success')"
assert_stderr 

# Fails because there is nothing in stderr
run test_stderr python -c "print 'example assert_stderr failure'"
assert_stderr 

#assert_no_stdout
# Success
run test_no_stdout python -c "import sys; sys.stderr.write('example assert_no_stdout success')"
assert_no_stdout 

# Fails because there is something in stdout
run test_no_stdout python -c "print 'example assert_no_stdout failure'"
assert_no_stdout 

#-- assert_no_stderr
# Success
run test_no_stderr python -c "print 'example assert_no_stderr success'"
assert_no_stderr 

# Fails because there is something in stderr
run test_no_stderr python -c "import sys; sys.stderr.write('example assert_no_stderr failure')"
assert_no_stderr 

#--assert_exit_code
# Success
run test_exit_code python -c "print 1;"
assert_exit_code $EX_OK 

run test_exit_code python -c "import sys; sys.exit(66);"
assert_exit_code $EX_NOINPUT 

# Fails because the error code is wrong
run test_exit_code python -c "import sys; sys.exit(66);"
assert_exit_code $EX_USAGE 

#assert_equal - numbers
# Success
touch test.out
run test_equal python -c "f = open('test.out','w'); f.write('1\n2\n3\n');f.close();"
assert_equal "$(cat test.out | wc -l)" 3 

run test_equal python -c "f = open('test.out','w'); f.write('1\n2\n3\n');f.close();"
# Failure
assert_equal "$(cat test.out | wc -l)" 4 
rm -f test.out

#assert_equal - strings
# Success
touch test.out
run test_equal python -c "f = open('test.out','w'); f.write('foo\n');f.close();"
assert_equal "$(cat test.out)" foo

run test_equal python -c "f = open('test.out','w'); f.write('foo\n');f.close();"
# Failure
assert_equal "$(cat test.out)" bar
rm -f test.out

#using STDOUT_FILE
run use_stdout_file python -c "print '1\n2\n3';"
assert_equal "$(cat $STDOUT_FILE | wc -l)" 3 

