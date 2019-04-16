ssshtest - **s**tupid **s**imple (ba)**sh** **test**ing
=======================================================

[![Build Status](https://travis-ci.org/ryanlayer/ssshtest.svg?branch=master)](https://travis-ci.org/ryanlayer/ssshtest) [![Docs](https://img.shields.io/badge/docs-latest-blue.svg)](http://ryanlayer.github.io/ssshtest/)

![example output](https://raw.githubusercontent.com/ryanlayer/ssshtest/master/docs/screenshot.png)

`ssshtest` is designed to be practical and easy to use.

To use `ssshtest` in your project just source it in your test file

```
test -e ssshtest || wget -q https://raw.githubusercontent.com/ryanlayer/ssshtest/master/ssshtest
. ssshtest
```

Then write some tests:

```
run test_for_success python -c "print 'zzz: example success'"
assert_in_stdout "zzz"

run test_for_stderr python -c "sys.stderr.write('zzz: example failure')"
assert_in_stderr "xxx"
```

Then simply run the bash file that contains those lines.

```
$ bash mytests.sh
```

To run only certain tests, use:

```
$ bash mytests.sh test_for_success test_42
```


For an example of how to use **travis** continuous integration tests, our [.travis.yml](https://github.com/ryanlayer/ssshtest/blob/master/.travis.yml)




Functions
=========

run (2)
-------

run a block of code. This must precede any of the testing functions below.

###Arguments

+ name for test.
+ code to run

assert_equal (2)
----------------

Assert that 2 things are equal.
This does a string comparison so assert_equal "2" "  2" will fail.

###Arguments

+ observed
+ expected

```
assert_equal 42 $((21 + 21))
```

assert_stdout (0)
-----------------

Assert that stdout is not empty

```
run test_stdout python -c "print 'zzz: example success'"
assert_stdout
```

assert_in_stdout (1)
--------------------

Assert that stdout out contains this text.

```
run test_in_stdout python -c "print 'zzz: example success'"
assert_in_stdout "zzz"
```

###Arguments

+ text to match


assert_no_stdout (0)
--------------------

Assert that stdout is empty

```
run test_empty_stdout python -c "import sys; sys.stderr.write('aaa')"
assert_no_stdout
```


assert_stderr (0)
-----------------

Assert that stderr is not empty

```
run test_stderr python -c "import sys; sys.stderr.write('zzz: example success')"
assert_stderr
```

assert_in_stderr (1)
--------------------

Assert that stderr out contains this text.

###Arguments

+ text to match

```
run test_in_stderr python -c "import sys; sys.stderr.write('zzz: example success')"
assert_in_stderr "zzz"
```

assert_no_stderr (0)
--------------------

Assert that stderr is empty

```
run test_no_stderr python -c "print 'aaa'"
assert_no_stderr
```

assert_exit_code (1)
--------------------

Assert that the program exited with a particular code

###Arguments

+ exit code

```
run test_exit_code python -c "import sys; sys.exit(33)"
assert_exit_code 33
```

Variables
=========

STOP_ON_FAIL
------------

Set STOP_ON_FAIL=1 after sourcing `ssshtest` to stop on the first error. Default is to continue running

STDOUT_FILE
-----------

`$STDOUT_FILE` is a file containing the $STDOUT from the last run command

STDERR_FILE
-----------

`$STDERR_FILE` is a file containing the $STDERR from the last run command

`$test_name`
-----------
`ssshtest` allows you to run a subset of the tests in your test file, and an
environment variable is set for to each test that is set to run.  You can use
this variable to prevent lines associated with a test from running when the
test not set to run. For example, the following test creates the file
`test.txt`. 

```
rm -f test.txt
run write_test \
    python -c 'f=open("test.txt","w");f.write("test\n");f.close()'
assert_equal "test" $( cat test.txt )
```

If this test is not run the file is not created, and when the shell attempts to
resolve `$( cat test.txt )` the error `cat: test.txt: No such file or
directory` occurs.

You can prevent this error by putting a test-specific guard around the assert.

```
rm -f test.txt
run write_test \
    python -c 'f=open("test.txt","w");f.write("test\n");f.close()'
if [ $write_test ]; then
    assert_equal "test" $( cat test.txt )
fi
```

LICENSE
=======

MIT LICENSE
