ssshtest - **s**tupid **s**imple (ba)**sh** **test**ing
=======================================================

[docs](http://ryanlayer.github.io/ssshtest/)

`ssshtest` is designed to be practical and easy to use.

To use `ssshtest` in your project just source it in your test file

```
. ssshtest
```

Then write some tests:

```
run test_for_success python -c "print 'zzz: example success'"
assert_in_stdout "zzz" $LINENO

run test_for_stderr python -c "sys.stderr.write('zzz: example failure')"
assert_in_stderr "xxx" $LINENO
```

Then simply run the bash file that contains those lines.

```
$ bash mytests.sh
```

To run only certain tests, use:

```
base mytests.sh test_for_success test_42
```



Functions
=========

run (2)
-------

run a block of code. This must precede any of the testing functions below.

###Arguments

+ name for test.
+ code to run

assert_equal (3)
----------------

Assert that 2 things are equal:

###Arguments

+ observed
+ expected
+ $LINENO

```
assert_equal 42 $((21 + 21)) $LINENO
```

assert_stdout (1)
-----------------

Assert that stdout is not empty

###Arguments

+ $LINENO

```
run test_stdout python -c "print 'zzz: example success'"
assert_stdout $LINENO
```

assert_in_stdout (2)
--------------------

Assert that stdout out contains this text.

```
run test_in_stdout python -c "print 'zzz: example success'"
assert_in_stdout "zzz" $LINENO
```

###Arguments

+ text to match
+ $LINENO


assert_no_stdout (1)
--------------------

Assert that stdout is empty

###Arguments

+ $LINENO

```
run test_empty_stdout python -c "import sys; sys.stderr.write('aaa')"
assert_no_stdout $LINENO
```


assert_stderr (1)
-----------------

Assert that stderr is not empty

###Arguments

+ $LINENO

```
run test_stderr python -c "import sys; sys.stderr.write('zzz: example success')"
assert_stderr $LINENO
```

assert_in_stderr (2)
--------------------

Assert that stderr out contains this text.

###Arguments

+ text to match
+ $LINENO

```
run test_in_stderr python -c "import sys; sys.stderr.write('zzz: example success')"
assert_in_stderr "zzz" $LINENO
```

assert_no_stderr (1)
--------------------

Assert that stderr is empty

###Arguments

+ $LINENO

```
run test_no_stderr python -c "print 'aaa'"
assert_no_stderr $LINENO
```

assert_exit_code (2)
--------------------

Assert that the program exited with a particular code

###Arguments

+ exit code
+ $LINENO

```
run test_exit_code python -c "import sys; sys.exit(33)"
assert_exit_code 33 $LINENO
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


LICENSE
=======

MIT LICENSE
