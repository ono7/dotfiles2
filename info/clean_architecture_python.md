# SOME PYTHON TDD STUFF I NEED TO REMEMBER

#### RESOURCES

I will never recommend enough Sandi Metz’s talk “The Magic Tricks of Testing” where

#### Vocab

**Idempotency**
  In computing, an idempotent operation is one that has no additional effect if
  it is called more than once with the same input parameters.

## Focus on messages for testing

Messages have 3 different origins, and there are two types: **QUERIES and COMMANDS**

* **incoming**

* **sent to self**

* **outgoing**
# DO NOT TEST CODE OUTSIDE OF THE COMPONENT WE ARE TESTING

This gives us 6 message variations that we can tests against

## message types examples


**SELF** is the object we are testing

### (outside, self)

  - incoming - contains messages that other compoents send to our object

### (self, self)

  - self - messages internal to our component, need no testing

  do not test private methods that use internal logic, they are already tested
  by the tests of the public entry points

### (self, outside) - outgoing - messages from our object to other component/s on the domain

  Outgoing queries and commands An outgoing query is a message that the component
  under testing sends to an external actor asking for a value, without changing
  the status of the actor itself. The correctness of the returned value, given
  the inputs, is not part of what you want to test, because that is an incoming
  query for the external actor. **Let me repeat this: you don’t want to test that
  the external actor return the correct value given some inputs, that is an
  incoming query to that actor**.  incomming messages for that external actor should be
  tested in its own test suite. its ok to test the data before it leaves our component


* Testing is all about the behaviour of a component when it is used, i.e. when it
is connected to other components that interact with it. This

  **flow    type     test**
  `--------------------------`
  incoming  query    yes
  incoming  command  yes
  private   query    maybe/no
  private   command  maybe/no
  outgoing  query    mock
  outgoing  command  mock


## compare None with "is" not ==

## using pdb

* use pdb in the unittest it self
* use pdb in the code where the exception happens
* if using pdb test must be called externally with python -m unittest discover test/


#### RULES

**write code that passes test, then refactor**


# TYPES OF TESTS

* **integration tests** - try to put together different systems to make sure they work together

* **unittest** should be small and contained to your system, use mock when possible to keep test
  with in bounds, keep tests focused and small




#### RESOURCES

I will never recommend enough Sandi Metz’s talk “The Magic Tricks of Testing” where


