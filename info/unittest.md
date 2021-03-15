# project structure for unittest

**FIND THE SIMPLICITY THAT LIVES AT THE HEART OF COMPLEXITY**

1. Test first, code later
2. Add the bare minimum amount of code you need to pass the tests
3. You shouldn’t have more than one failing test at a time
4. Write code that passes the test. Then refactor it.
5. A test should fail the first time you run it. If it doesn’t ask yourself, why?
6. Never refactor without a test

###  Three kinds of tests

  * Test incomming messages

  * Test outgoing messages
    - If a message has **NO SIDE EFFECTS** the sender should not test it

  * Test sent to self, invisible to things on the outside

  **IGNORE THESE, DONT SPEND TOO MUCH TIME ON THEM**

  * someones incomming message its some one else's outgoing message

  *  **DO NOT TEST PRIVATE METHODS**, dont waste time in testing them
  * **BREAK RULES** if its saves money!!, people do may not want to improve your tests if its
  too complicated, better to delete complex implementations


There can only be **two types**, each **SHOULD BE TESTED SEPARATELY**

**Query**
  * return something, change nothing
  * test the interface not the implementation, I only care about the messages
  that come back!!
  * assert direct public side effects

**Commands**
  * return nothing, change something



#### RESOURCES

**Sandi Metz’s talk “The Magic Tricks of Testing” where**

  https://www.youtube.com/watch?v=URSWYvyc42M

  * unittest prove that every cell behaves correctly
  * we want the unittest to be stable
  * test should be fast
  * there should only be few

  * Thorough, stable, fast, few


### unitest must run from app root folder to avoid import issues

### default search pattern for unit test is `test_*.py`

### example directory struture

├── app.py
├── blog.py
├── post.py
└── tests
    ├── __init__.py
    ├── integration
    │   ├── __init__.py
    │   └── blog_test.py
    └── unit
        ├── __init__.py
        ├── blog_test.py
        └── post_test.py

* each folder inside the test module `(__init__.py)` is not compliant with the
  default search pattern

python -m unittest discover -p '*_test.py' -v

* if the files name used the default pattern `test*.py` we can execute the
  following instead

python -m unittest

* unit test is a single element or unit of code to be tested

* test that require more then 1 unit of test should be tested separetely, in
  this example we use an integrations directory

