# MOCK

```python

In [10]: from unittest import mock

In [11]: m = mock.Mock()

In [12]: dir(m)
Out[12]:
['assert_any_call',
 'assert_called_once_with',
 .....
 'assert_called_with',
 'side_effect']
# when you call an attribute that does not exist
# mock records it, you can assign a value to it
In [14]: m.test
Out[14]: <Mock name='mock.test' id='4622134928'>
In [15]: m.test
Out[15]: <Mock name='mock.test' id='4622134928'>
# configure mock to return any value on that object you created
In [18]: m.test.return_value = 2000
In [19]: m.test()
Out[19]: 2000
```
As you can see this class is somehow different from what you are used to. First
of all, its instances do not raise an AttributeError when asked for a
non-existent attribute, but they happily return another instance of Mock
itself. Second, the attribute you tried to access has now been created inside
the object and accessing it returns the same mock object as before.

* mock objectts are callables and can be used as attributes or methods

* make sure that the value assinged to the mocked object is not callable or it will return the
  callable item instead of the value, see **side effect**

```python

In [23]: def print_answer():
    ...:     print("42")
    ...:

In [24]: m.atttest2.return_value = print_answer

In [25]: m.atttest2()
Out[25]: <function __main__.print_answer()>

```

## side_effect

can accept 3 types of objects

**callables**
**iterables**
**exceptions**

it can change its behaivour accordingly based on the object passed

```python
""" testing mocks """
from unittest import mock

class MyObj:
    """ test mock objects """

    def __init__(self, repo):
        repo.connect()

def test_connect():
    ex_obj = mock.Mock()
    MyObj(ex_obj)
    ex_obj.connect.assert_called_with()
```

* mock becomes "repo" above and since repo has a method called repo.connect()
  mock can then use assert_called_with() to make sure repo.connect() was called
  with no arguments

**CHECK OUTGOIN PARAMETERS NOT RESULTS WHEN TESTING OUTGOING COMMANDS**

* outgoing queries can be mocked so that we cant test with concistent data

* Remember that this is an outgoing command, so we are interested in checking
  the parameters and not the result.


* mock patching with context, assertion is done inside the context manager

```python

""" fileinfo tests """
from fileinfo import FileInfo
from unittest.mock import patch


def test_init():
    filename = "test.txt"
    fi = FileInfo(filename)
    assert fi.filename == filename


def test_init_relative():
    filename = "test.txt"
    relative_path = "../{}".format(filename)
    fi = FileInfo(relative_path)
    assert fi.filename == filename


def test_get_info():
    filename = "test.txt"
    original_path = "../{}".format(filename)
    with patch("os.path.abspath") as path_mock:
        test_abspath = "some/abs/path"
        path_mock.return_value = test_abspath
        fi = FileInfo(original_path)
        assert fi.get_info() == (filename, original_path, test_abspath)

# assertion is done inside the context when patching with patch context manager

===================== test session starts ======================

platform darwin -- Python 3.7.7, pytest-5.4.1, py-1.8.1, pluggy-0.13.1
rootdir: /Users/jlima/code/ddd/clean_arch/fileinfo
collected 3 items

test_fileinfo.py ...                                     [100%]

====================== 3 passed in 0.02s =======================

# alternative to patching with decorators

@patch("os.path.abspath")
def test_get_info_with_decorator(abspath_mock):
    test_abspath = "some/path/"
    abspath_mock.return_value = test_abspath
    filename = "sometextfile.txt"
    original_path = f"../{filename}"
    fi = FileInfo(original_path)
    assert fi.get_info() == (filename, original_path, test_abspath)

# multiple queries can be patched, with multiple decorators
# the decorator nearest to the function is applied first,
# in this case os.path.getsize
@patch("os.path.abspath")
@patch("os.path.getsize")
def test_get_info_with_decorator(abspath_mock, getsize_mock):
    test_abspath = "some/path/"
    abspath_mock.return_value = test_abspath
    test_size = 1024
    getsize_mock.return_value = test_size
    filename = "sometextfile.txt"
    original_path = f"../{filename}"
    fi = FileInfo(original_path)
    assert fi.get_info() == (filename, original_path, test_abspath)
    assert fi.get_size() == test_size

```
# MOCK - assert_called_with

* use mock assertitions to tests that the correct parameters were passed to the
  function being tested

**Patching and Mocks**

Mocks are very simple to introduce in your tests whenever your
objects accept classes or instances from outside.



