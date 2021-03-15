# pytest, udemy notes

```python
def test_greet():
    bob = {"name": "Bob"}       # arrange
    greeting = greet(bob)       # act
    assert greeting == "hi Bob" # assert
pytest -v , verbose output
```

name files starting with test_

functions should be very descriptive, and should start with the word test_:

  test_widget_functions_as_expected()

functions that do not start with test do not run in the test


# pytest.ini
you can create a pytest.ini  to do some things such as functions/directory/filenames to test for


# you can create as many directories as needed for testing


test/
└── sportscar
    ├── body
    ├── engine
    └── entertainment




# mark functions, functions must be registered in pytest.ini

```python
from pytest import mark

@mark.engine
def test_engine_functions():
    assert True
```

# running with marks

pytest -m engine,body,smoke

pytest -m "body and engine" -> test must have both tags defined

pytest -m "not engine" -> run everything except engine

# view all markers and other useful information on filtering with -m

pytest --markers

# catch raised exception

```python

def test_func():
  with pytest.raise(TypeError):
    task.add(task='not the right obj type')
```

# skip markers, are used to skip some test

skip, skipif, xfail

# to run a single function

`pytest -v tests/func/test_add.py::test_add_returns_valid_id`

# use -k to filter test with certain patterns

`pytest -v -k _raises

  tests/func/test_api_exceptions.py::test_add_raises PASSED
  tests/func/test_api_exceptions.py::test_list_raises PASSED
  tests/func/test_api_exceptions.py::test_get_raises PASSED
  tests/func/test_api_exceptions.py::test_delete_raises PASSED
  tests/func/test_api_exceptions.py::test_start_tasks_db_raises PASSED

pytest -v -k "_raises and not delete"

`

# @pytest.mark.parametrize(argnames, argvlaues) -> runs this args as a loop

```python

# pass a single parameter
@pytest.mark.parametrize('task', [ Task('sleep', done=True), Task('wake', 'brian')])
def test_add_2(task):
  assert True

# pass multiple parameters
@pytest.mark.parametrize(
    "summary, owner, done",
    [
        ("sleep", None, False),
        ("wake", "jose", False),
        ("breath", "Brian", True),
        ("eat eggs", "brIan", False),
    ],
)
def test_add_3(summary, owner, done):
    """ Demonstrate parametrize with multiple parameters """
    task = Task(summary, owner, done)
    task_id = tasks.add(task)
    t_from_db = tasks.get(task_id)
    assert equivalent(t_from_db, task)

```

# a node is pytest lingo for the name of the test

you can call the test by it self using the node name

```
pytest test_parametrize.py::test_add_3[breath-Brian-True]
```

use quotes if there are spaces in the node name



# Mock

https://realpython.com/testing-third-party-apis-with-mocks/

* Use a decorator when all of the code in your test function body uses a mock.

* Use a context manager when some of the code in your test function uses a mock
  and other code references the actual function.

* Use a patcher when you need to explicitly start and stop mocking a function
  across multiple tests (e.g. the setUp() and tearDown() functions in a test
  class).

## fixtures

* shows fixture setup and tear down

  pytest --setup-show

* fixtures should use autouse=True/scope= (function, class, module, session), default is function

# Time test fixture

```python
""" this run every time and time the fixture test indidually, if necessary """
import pytest
import time

@pytest.fixture(autouse=True)
def footer_function_scope():
  """Report test durations after each function."""
  start = time.time()
  yield
  stop = time.time()
  delta = stop - start
  print('\n test duration : {:0.3} seconds' .format(delta))


""" Rename fixtures """

@pytest.fixture(name='lue')
def ultimate_answer_to_life_the_universe_and_everything():
  """Return ultimate answer."""
  return 42

def test_this_shorter_version_of_fixture(lue):
  assert lue == 42
```

# BUILTIN FIXURES

### tmpdir

* tmpdir, create a temporary directory

* can be used with tmpdir.join('somefile.txt') to create files

* can read and write files with a_file.read, a_file.write

* tmpdir is anoject type py.path.local

* tmpdir has a function level scope

### tmpdir_factory

* is like tmpdir but has a different interface
*
