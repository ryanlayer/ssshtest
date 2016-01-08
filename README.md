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
run python -c "print 'zzz: example success'"
assert_in_stdout "zzz" $LINENO

run python -c "sys.stderr.write('zzz: example failure')"
assert_in_stderr "xxx" $LINENO
```

Then simply run the bash file that contains those lines.


Functions
=========

run (1)
-------

run a block of code. This must precede any of the testing functions below.

###Arguments

+ code to run


assert_stdout (1)
-----------------

Assert that stdout is not empty

###Arguments

+ $LINENO

```
run python -c "print 'zzz: example success'"
assert_stdout $LINENO
```

assert_in_stdout (2)
--------------------

Assert that stdout out contains this text.

```
run python -c "print 'zzz: example success'"
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
run python -c "import sys; sys.stderr.write('aaa')"
assert_no_stdout $LINENO
```


assert_stderr (1)
-----------------

Assert that stderr is not empty

###Arguments

+ $LINENO

```
run python -c "import sys; sys.stderr.write('zzz: example success')"
assert_stderr $LINENO
```

assert_in_stderr (2)
--------------------

Assert that stderr out contains this text.

###Arguments

+ text to match
+ $LINENO

```
run python -c "import sys; sys.stderr.write('zzz: example success')"
assert_in_stderr "zzz" $LINENO
```

assert_no_stderr (1)
--------------------

Assert that stderr is empty

###Arguments

+ $LINENO

```
run python -c "print 'aaa'"
assert_no_stderr $LINENO
```

assert_exit_code (2)
--------------------

Assert that the program exited with a particular code

###Arguments

+ exit code
+ $LINENO

```
run python -c "import sys; sys.exit(33)"
assert_exit_code 33 $LINENO
```

Variables
=========

STOP_ON_FAIL
------------

Set STOP_ON_FAIL=1 after sourcing `ssshtest` to stop on the first error. Default is to continue running

LICENSE
=======

MIT LICENSE
