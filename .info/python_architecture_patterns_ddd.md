# MAIN LAYERS

# cognitive load

https://blog.prototypr.io/design-principles-for-reducing-cognitive-load-84e82ca61abd

1. too many choices
2. too much thought required
3. lack of clarity

* decision paralisys, when too many choices are presented
  - minimize choices


#### CHUNCKING!
* Chunking, when you are running out of cognitive registers when solving a
  problem, chunck it, this will make it easier to deal with.
  - chucking simply means breaking it into groups

#### ALIASING

* when chunking you can take the problem down to 1 register, but we can take
  this down to zero registers by aliasing

* Aliasing links one problem to something you already know, this takes this
  register down to 0 use and its easier to remember.


# short variable names

* java
if a > b ? a : b

* python
a if a > b else b


# PYTHON ARCHITECTURE PATTERNS AND DDD

* Your elements should talk inwards, that is pass data to more
abstract elements, using basic structures provided by the
language (thus globally known) or structures known to those
elements.

* Your elements should talk outwards using interfaces, that is
using only the expected API of a component - **with out
refering to a specific implementation**


**domain** is the business or the problem that we are trying to solve with our
  software

**If you cant explain it simply you dont understand it well enough**
    --Albert Einstein

**Its not the customers' job to know what they want**
    --Steve Jobs

**A system that does not solve the business need is of no use to anyone**

**Its the developer's understanding not his knowledge that becomes software**
  - how well you understand the domain will dictate how well the software produced is
  - you must understand the problem to produce good software



# IN DDD, THINK IN TERMS OF CONTEXTS



  - A context is a setting in which a word or statement appears that determines
  its meaning

**Bounded context**
  - keeping things related
  - something that means something inside a context can mean something else
  inside the model

**context map**
  - how bounded context relate to eachother

**Domain model**
  - its an interpretation of reality
  - the aspects chosen for implementation that constitute the model

**Ubiquitous language**
  - language inside a context should be related, var names, class/func names,
  test code

**Layer architecture & advantages**

  - requests handlers
    * you can take requests faster

  - controllers
    * everything is organized and well defined

  - business
    * increased flexibility and maintainability

  - persistance (business helpers)
    * reusable components

**Value Objects**
  - reduces complexity and forces ubiquitous language
  - they dont care about uniqueness
  - are always immutable, rich in domain logic and auto validating (sets, namedtupples)
  - they have strong equality

**Aggregates**
  - collection of entities and values which come under a single transaction boundary

    [ customer -> customerInfo, Address ] the root is Custumer
    [ Order -> OrderId, OrderInfo ] the root is Order

  - use factories to create new aggreates

**Repositories**
  - used to create persisted aggregates

**Event storming**
  - its an exercise for creating Domain Models for strategic design

**HOW**
  - bring the right people in to answer the questions
  - create a template, events, commands, policies, processes, errors, roles,
  aggregates
  - after the first pass, start identifying bounded contexts, what goes where?
  - always first think about your boundary context, subdomains etc
  - think about each subdomain separately
  - focus on what distinguises us from our competitors
  - dont chase shiny objects by throwing tech at the problem (write in a particular one off language etc)
  - write code and documentation so that it represents the domain
  - build a product for which you can provide long term warranties (use DDD)
  - build autonmous modules, remove dependencies from each other

**Dont work for a company that thinks of software as a cost center**



## CODE:


    https://github.com/cosmicpython/code/branches/active

* domain driven design
* event driven microservices
* manage complexity and solve business problems

`python zen`

  “There should be one and preferably only one obvious way to do it.”



# ADDTIONAL READS:



  And this book isn’t a replacement for the classics in the field such as Eric
  Evans’s Domain-Driven Design or Martin Fowler’s Patterns of Enterprise
  Application Architecture (both published by Addison-Wesley Professional ) which
  we often refer to and encourage you to go and read.



## DDD - DOMAIN DRIVEN DESIGN



**Domain** Is the business or the problem that we are trying to solve with our software

asks us to focus our efforts on building a good model of the business
domain, but how do we make sure that our models aren’t encumbered
with infrastructure concerns and don’t become hard to change?



## MICROSERVICES & MONOLITHIC APPLICATIONS



* microservices - small even driven architecture
* monolithic - apps that encapsulate all the logic

Domains can be subcategorized into subdomains



## MAIN POINTS



  * think of code in terms of behaviour rather than in terms of data and
  algorithms

  * abstraction: simplified interfaces that encapsulate behaviour

  * one of the most common reasons that our designs go wrong is
  that business logic becomes spread througout the layers of our
  application, making it hard to identify, understand and change

  * behaiviour should come first, when doing domain driving
  design, the backend architecture last



#### THE DEPENDENCY INVERSION PRINCIPLE



1. high level modules should not depend on low level modules, Both
   should depend on abstraction

  * this is the code the org depends on
  * this modules deal with with real world concepts (functoins and classes)

2. Abstraction should not depend on details. instead, details
   should depend on abstraction

Low level modules interact with file systems and network sockets,
this are low level and the org doesnt care about them much

3. The business code should not depend on technical details,
   instead both should use abstraction, we need to be able to change
   them independently of each other



### THREE LAYER ARCHITECTURE



1. Presentation layer

2. Business logic | Domain model (same thing)

3. Database layer



### CHAPTER 1, MAIN POINTS



Patterns:

  1. repostatory pattern, an abstraction over the idea of
    persistent storage

  2. the service layer pattern to clearly define where our use
    cases begin and end

  3. the unit of work pattern, provide atomic operations

  4. the aggreate pattern, to enforce the integrity of our data



### DOMAIN MODEL == BUSINESS LAYER





#### DOMAIN IS A FANCY WAY OF SAYING THE PROBLEM YOU ARE TRYING TO SOLVE



depending on which system we are talking about the domain might
change

purchasing, procurement, product design or logistics and delivery,
when talking about a online retailer

Most programmers spend thier day trying to improve or automate
business processes; the domain is the set of activities that those
processes support



## PATTERNS



* Value Object patternk

Whenever we have a business concept that has data but no identity, we often
choose to represent it using the Value Object pattern.

```python

from dataclasses import dataclass
from typing import NamedTuple
from collections import namedtuple

@dataclass( frozen = True )
class Name :
  first_name : str
  surname : str

class Money( NamedTuple ):
  currency : str
  value : int

Line = namedtuple ( 'Line' , [ 'sku' , 'qty' ])

def test_equality():
  assert Money ( 'gbp' , 10 ) == Money ( 'gbp' , 10 )
  assert Name ( 'Harry' , 'Percival' ) != Name ( 'Bob' , 'Gregory' )
  assert Line ( 'RED-CHAIR' , 5 ) == Line ( 'RED-CHAIR' , 5 )

```


## EXCEPTIONS SHOULD BE NAME ACCORDING TO OUR MODULES



Raising a domain exception (model.py)
```python

class OutOfStock(Exception):
  pass

```
Percival, Harry,Gregory, Bob. Architecture Patterns with Python (Kindle Locations 770-772). O'Reilly Media. Kindle Edition.



### VOCABULARY



  * extraneous - irrelevant and unrelated
  * DDD - domain driven design
  * TDD - test drive development
  * Service layer - defines entry points into the system
  * even drive architecture

      * Domain events - vehicles for capturing the idea that some
      interactions with a system are triggers for others

      * Message Bus - allow actions to trigger events and call
      appropiate handlers

      * Handler patterns - events can be used as patterns for
      intergrations between services in a microservice architecture



### VIDEO NOTES



* **Value Objects** are used to **measure** and describe things in the domain
  describe characteristics, like currency value, immutable

  - rely on builtin immutables, tuple, string, frozenset
  - validate them in initializer, `__init__ or __new__`
  - property getters with @property
  - override equality/inequality with `__eq__() or __ne__()`
  - use a useful `__repr__()`
  - use side effect free functions to provide new values

* **entities**
  - the can be made of other entities or value objects

* **aggregates**
  - concistency boundaries
  - appear as cluster entities
  - they contain one root aggregate which a

* **onion model**
  - the appl is not about databases, its about solving a problem

* **one python package per domain/context**

**implementing DDD in code part 1**
  https://www.youtube.com/watch?v=B-9RsRmC6sA

  do the checking for things as they enter the domain in one place, and tag it so every one
  knows the checking has already been done



## SPEND MOST TIME ON DESIGN



  * we need carefully written specifications
