#!/bin/bash

. ssshtest

STOP_ON_FAIL=0

#--- assert_in_stdout
# Success
run python -c "print 'example assert_in_stdout success'"
assert_in_stdout "example" $LINENO

# Fails because there is nothing in stdout
run python -c "import sys; sys.stderr.write('example assert_in_stdout failure')"
assert_in_stdout "example" $LINENO

# Fails because "simple test" is not in stdout
run python -c "print 'example assert_in_stdout success'"
assert_in_stdout "simple test" $LINENO


#--- assert_in_stderr
# Success
run python -c "import sys; sys.stderr.write('example assert_in_stderr success')"
assert_in_stderr "example" $LINENO

# Fails because there is nothing in stderr
run python -c "print 'example assert_in_stderr failure'"
assert_in_stderr "example" $LINENO

# Fails because "simple test" is not in stderr
run python -c "import sys; sys.stderr.write('example assert_in_stderr success')"
assert_in_stderr "simple test" $LINENO

#--- assert_stdout
# Success
run python -c "print 'example assert_stdout success'"
assert_stdout $LINENO

# Fails because there is nothing in stdout
run python -c "import sys; sys.stderr.write('example assert_stdout failure')"
assert_stdout $LINENO

#--- assert_stderr
# Success
run python -c "import sys; sys.stderr.write('example assert_stderr success')"
assert_stderr $LINENO

# Fails because there is nothing in stderr
run python -c "print 'example assert_stderr failure'"
assert_stderr $LINENO

#assert_no_stdout
# Success
run python -c "import sys; sys.stderr.write('example assert_no_stdout success')"
assert_no_stdout $LINENO
# Fails because there is something in stdout
run python -c "print 'example assert_no_stdout failure'"
assert_no_stdout $LINENO

#-- assert_no_stderr
# Success
run python -c "print 'example assert_no_stderr success'"
assert_no_stderr $LINENO
# Fails because there is something in stderr
run python -c "import sys; sys.stderr.write('example assert_no_stderr failure')"
assert_no_stderr $LINENO

#--assert_exit_code
# Success
run python -c "print 1;"
assert_exit_code $EX_OK $LINENO
run python -c "import sys; sys.exit(66);"
assert_exit_code $EX_NOINPUT $LINENO

# Fails because the error code is wrong
run python -c "import sys; sys.exit(66);"
assert_exit_code $EX_USAGE $LINENO

#assert_fail_to_stderr
# Success
run python -c "import sys; sys.stderr.write('example assert_no_stderr failure');sys.exit(66)"
assert_fail_to_stderr $EX_NOINPUT $LINENO
# Fails because the exit code is wrong
run python -c "import sys; sys.stderr.write('example assert_no_stderr failure');sys.exit(65)"
assert_fail_to_stderr $EX_NOINPUT $LINENO
# Fails because there is something in stdout
run python -c "import sys; print 'something'; sys.stderr.write('example assert_no_stderr failure');sys.exit(66)"
assert_fail_to_stderr $EX_NOINPUT $LINENO
# Fails because there is nothing in stderr
run python -c "import sys; print 'something'; sys.exit(66)"
assert_fail_to_stderr $EX_NOINPUT $LINENO
