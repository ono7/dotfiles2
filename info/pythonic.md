# pythonic way of doing things going forward

## new functions learned

```python
# all() accepts an iterable and returns true only if all values are true

a = [ 0, 1 ]
if all(a):
  print(a)

# returns true if all objects return true, 0 is false so this will fail

a = [ 1, 1 ]
if all(a):
  print(a)

# this prints the list a
```


#### DO THIS THINGS


#### DOMAIN DRIVEN DESIGN

* **kindle architecture patterns with python**

  * domain driven design
  * even driven microservices

It seems like you are asking about the difference between the data model and
the domain model – the latter is where you can find the business logic and
entities as perceived by your end user, the former is where you actually store
your data.

Furthermore, I've interpreted the 3rd part of your question as: how to notice
failure to keep these models separate.

These are two very different concepts and it's always hard to keep them
separate. However, there are some common patterns and tools that can be used
for this purpose.

# About the Domain Model

The first thing you need to recognize is that your domain model is not really
about data; it is about actions and questions such as "activate this user",
"deactivate this user", "which users are currently activated?", and "what is
this user's name?". In classical terms: it's about queries and commands.

# Thinking in Commands

Let's start by looking at the commands in your example: "activate this user"
and "deactivate this user". The nice thing about commands is that they can
easily be expressed by small given-when-then scenario's:

  - given an inactive user
  - when the admin activates this user
  - then the user becomes active
  - and a confirmation e-mail is sent to the user
  - and an entry is added to the system log (etc. etc.)

Such scenario's are useful to see how different parts of your infrastructure
can be affected by a single command – in this case your database (some kind of
'active' flag), your mail server, your system log, etc.

Such scenario's also really help you in setting up a Test Driven Development
environment.

And finally, thinking in commands really helps you create a task-oriented
application. Your users will appreciate this :-)



* TEACH EMMA PROBLEM SOLVING (PROGRAMMING SKILLS)

* use generator functions, for scale and performance
  - scale by creating, source, filter, map or sink operations

    * source, data coming in
    * filter, data filtered or map
    * sink, consumer of filtered data
    * use generator comprehentions, sub [] for ()

      In [11]: x = ( n * 8 for n in range(200) )
      In [12]: type(x)
      Out[12]: generator

* use d.get() and d.setdefault() for dictionaries
* use the APIs on the objects to do things, more efficient
* use chunking ans aliasing, human has 7 register +- two at any time

  - group things together func1(func2(func3))
  - phone numbers are chucked to remeber easier
  - aliasing, take an existing thing you know and link it

      https://youtu.be/UANN2Eu6ZnM

* Error handling, always check type before value

* chuck classes, find comonalities, as in dcnm sessions module
  build a base class and inherit to reuse for more classes

* put examples of how to run your code in your docstrings, this helps with readability
  and helps you remember how your code is supposed to work

```python
python -i generator_house.py
{'address': '1423 99th Ave', 'square_feet': '1705', 'price_usd': '340210'}
{'address': '24257 Pueblo Dr', 'square_feet': '2305', 'price_usd': '170210'}
{'address': '127 Cochran', 'square_feet': '2068', 'price_usd': '320500'}
{'error': 'no data', 'square_feet': '2068', 'price_usd': '320500'}
>>>
```

* run coverage just like pytest, this shows you how much of your code has tests
  this way you know what code has tests for!


### PATTERNS

* repeat tasks manually until a pattern emerges, then move it to a function


### TOOLS

pyflake, pylint, flake8, bandit

## DO NOT DO THIS THINGS

* do not use for line in f.readlines() as it creates a list first
  for line in f: is better and it will pull one line at a time

```python
def match_line_infile(path, pattern):
    """ generator function """
    with open(path) as f:
      for line in f:
          if pattern in line:
              yield line.rstrip("\n")
```

* itertools!, create iterators as much as possile to take advantage of CPU cache

```python
for k, v in iter(d.items()):
  print(k,v)
```

# creating dictionaries with d.get()

* use d.get() when checking to see if a dictionary has a key
* d.get() will get the key and add a value if it does not have it

get() allows you to specify a default if it does not have it and give a value in the same line

```python
colors = ["green", "blue", "red", "orange"]
d = {}

for idx, color in enumerate(colors):
    d[color] = d.get(color, idx)

print("two", d)
```

# grouping with/using dictionaries

* use d.setdefault(key, []), allows to insert a missing value for the key

* d.setdefault(key, []).append('value'), also adds the value if the key exists

```python
names = [
    "raymond",
    "rachel",
    "matthew",
    "roger",
    "betty",
    "melissa",
    "judith",
    "charlie",
]

d = {} # define dictionary

for name in names:
    # key = len(name) # define key to use, use the number of letters for key
    key = name[0] # define key to use (alphabetical, nice!)
    d.setdefault(key, []).append(name) # see if key exists, if not, add it and populate it with [], append a value to it
print(d)
```
# always put global variables in all caps

```python
URL = 'https://google.com'
requests.get(URL)
```

# DO NOT mutate  dictionary   while iterating over it

# unpack variables is preffered

#### defined multiple variables inline/unpack

```python
def test1():
  x = 0
  y = 1

# to

def test1():
  x, y = 0, 1
```

#### use "generators" as much as possile

* generators are coroutines, unlinke functions that can have multiple
  exit points, generators can have multiple entry points

* each yield statement simultaneously defines an exti point
  and re-entry point

  * each time a new value is requested, the flow control
  picksup on the line after yeild in this case, the next line
  increments the variable n, then continues with the loop

```python
def gen_nums():
  n = 0
  while N < 4:
    yield n
    n += 1
for i in gen_nums(): print(i)

### type(gen_nums()) = generator!
```

#### Multiple entry points can be defined via multiple yields

```python
def gen_nums():
    n = 0
    while n < 4:
        yield n
        n += 1
    yield 90
# second yield (entry point, after while loop)
for i in gen_nums(): print(i)

# type(gen_nums()) = generator!

# use yield from where possible
def house_records_from_file(path):
    lines = lines_from_file(path)
    for house in house_records(lines):
        yield house

# yield from example, only used from they yield values
# from another generator object!
def house_records_from_file(path):
    lines = lines_from_file(path)
    yield from house_records(lines)
```
#### Merge dictionaries the pythonic way


```python
In [1]: route = { 'id' : 1 }
   ...: query = { 'id' : 27 }
   ...: post = { 'emmail': 'jlima@yahoo.com' }
   ...:
   ...: merge1 = { **route, **query, **post }
   ...:

In [2]: merge1
Out[2]: {'id': 27, 'emmail': 'jlima@yahoo.com'}
```

#### be explicit on fuction variables and use k,v pairs


```python
In [3]: def test1(username="", password="", endpoint=""):
   ...:     print(username, password, endpoint)

In [4]: test1(username="jose Lima", password="1234", endpoint="x")

      jose Lima 1234 x
```
#### you can force people to pass kwargs to function by using *

```python
In [5]: def test1(*, username, password, endpoint):
   ...:     print(username, password, endpoint)
   ...:

In [6]: test1('jose','123','test')
----------------------------------------------------------------
TypeError                      Traceback (most recent call last)
<ipython-input-6-dfc30abb8a2a> in <module>
----> 1 test1('jose','123','test')

TypeError: test1() takes 0 positional arguments but 3 were given

In [7]: test1(username='jose',password='123',endpoint='test')
jose 123 test

```

##### Use lambdas and pass them as parameters to functions

```python
In [28]: x.sort(key=lambda x: x[-1]);x
Out[28]: ['lima', 'emma', 'jose', 'shiloh', 'colby']

# lambdas are anonymous functions, and need a name or assignment
# can be used as a function parameter
In [31]: squares = lambda x: x ** 2
In [32]: squares(2)
Out[32]: 4

```


### Type hinting

annotate the type of variable and return value on the fuction if needed,

or you can just annotate the variable


```python
In [1]: def print_name(text: str) -> str:
   ...:     return f"hello {text}!!!"
   ...:
In [2]: print_name("jose lima")
Out[2]: 'hello jose lima!!!'

# OR

In [10]: def print_name(*,text: str):
    ...:     return f"hello jose {text}...."
    ...:
In [11]: print_name(text="jose lima")
Out[11]: 'hello jose jose lima....'

>>> def headline(text: str, align: bool = True) -> str:
...    if align:
...        return f"{text.title()}\n{'-' * len(text)}"
...    else:
...        return f" {text.title()} ".center(50, "o")
...
...

>>> print(headline("python type checking, align="left"))
Python Type Checking
--------------------

>>> print(headline("python type checking, align="center"))
Python Type Checking

```

# class inheritance, add new variables to new class

```python
""" testing """
from dcnm.core.session import SessionManager


class Sess(SessionManager):
    """ clone """

    def __init__(self, url, user, passwd, test=None):
        super().__init__(url, user, passwd)
# this inits from super class, keeping old variables and
# adding the rest of the initialized variables in __init__
        self.logon_url2 = "/test/test"
        self.test = test


conn = Sess("http://testing", "lima", "pw", test="hahaha")
```

```python
class OutOfStock ( Exception ):
  pass

def allocate ( line: OrderLine , batches: List [ Batch ]) > str:
  try :
    batch = next (
    ...
  except StopIteration:
    raise OutOfStock ( f'Out of stock for sku {line.sku}' )
```
