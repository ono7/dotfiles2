#### Resources:

- Domain Driven Design - Start with part 4, Eric Evans


* **Atomic operations**

  In computer programming, an operation done by a computer is considered atomic if
  it is guaranteed to be isolated from other operations that may be happening at
  the same time. Put another way, atomic operations are indivisible. Atomic
  operations are critically important when dealing with shared resources.

# Domain Drive Desing Mantra

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

**A system that does not solve the business need is of no use to
anyone**

**Its the developer's understanding not his knowledge that becomes software**
  - how well you understand the domain will dictate how well the software produced is
  - you must understand the problem to produce good software

## MODELING

* Use Event storming to create models

  - bring business experts and start putting together list of
  events

  - model the behaivour of the business and refactor if needed

  - "when" is a word that gives clues to an event, pay attention to business people as they
  talk about the domain when they use this word.

* Models describe the product or problem we are trying to solve,
write down the problem like this, find comonalities and create
entities around these for the use cases

https://www.youtube.com/watch?v=Ab5-ebHja3o

domain -> dcnm:
  create networks
    network id
    vxlan id

  attach networks
    networks
    switches to attach to
    peer switches

  interface attaches
    networks
    switches
    peer switches
    interfaces
    vcp enable

* two message types

  **commands** -> change something

  **events** -> are used to communicate something of significance
  has happened in the business

    * use events to communicate between bounded context


* use the right domain language when naming your classes/objects


# main components


* **Entities**

  *can manage their own errors*
  Contains a representation of the domain models that is
  everything your project needs to interact with and is
  sufficently complex to require a specific representation

  This layer will contain python classes, with methods that
  simplify interaction with them.

  This is the **inmost** layer, entities have mutual knowledge since they live in the same layer
  this means that one of the classes here can use andother
  one directly, instantiating it and calling its methods

  Entities dont know details about external interfaces, they
  only work with interfaces/abstrations


* **Use cases**

  **THIS IS WHERE WE IMPLEMENT THE ACTUAL BUSINESS LOGIC**
  *Can manage their own errors*
  contains the use cases implemented by the system, use
  cases are the processes that happen in your application,
  where you use your domain modles to work on real data,
  examples can be a user logging in, a search with specicif
  filters being performed, or a bank transaction happening
  when the user wants to buy the content of the cart

  - *use cases should be very small*, its important to isolate
  small actions in use cases, this makes the whole system
  easier to tests, understand and maintain

  - use cases know entities so they can instantiate them directly and use them.
  they can call eachother and it is common to create complex
  use cases that put together simpler ones

* **External Systems**
  This part of the architecture is made by external systems that implement the interfaces defined in the previous layer.
  Examples of these systems can be a specific framework that exposes an HTTP API, or specific database.

* **APIs and shades of gray**
  *The word API* is of uttermost importance in clean
  architecture.

  *Every layer may be accessed by elements
  living in inner layers by an API, that is fixed,
  collection of entry points (methods or objects)*

  *a well designed system shall also cope with practiccal
  world issues, such as performance, for example, or other
  specific needs.*

  *its very important to know what is where and why, even
  more so when you "bend" the rules, many decisions are
  shades of gray*

  **BE STRICT ABOUT DATA FLOW**
  if you break the dataflow you are invalidating the whole structure
  of clean architecture. but if it saves money, do it.

  if you do it, there should be a giant warning on the code on why it was done
  if you access an outer layer breaking the interface paradigm usually it is because
  some performanc issue as the layer structure can add some overhead to the communication
  between elements.

  * if you endup breaking data flow concistency, maybe you
  should consider merging the two layers that you are
  linking. data flow concistency refers to keeping the layers
  separated talking externally only through abstractions/interfaces.


* **Repository**
  * is the storage component, the source of information for
  the use case

  **STORAGE** lives in the 3rd layer of the clean architecture model

  The repository provides only the endpoints that the application needs.
  with an interface that is tailored to specific business problem.

# HOW TO INTERACT WITH THE SYSTEM (clean architecture/ddd)

* Initialise the repositories
* Initialise use cases
* collect results

  ```python
  repo = mr.MemRepo([]) # repository/db
  use_case = uc.RoomListUseCase( repo ) # init use case
  result = use_case.execute() # execute use case
  ```

# ERROR HANDLING

* the implementation on how to deal with errors is completely free
  and entirely up to us, the domain model says nothing about how
  to handle this request/responses

- domain driven design and event driven architecture = microservices


### CONTRAST DDD WITH UNIFIED/MONOLITHIC ARCH

1. mono/unified systems dont scale, hard to maintain, no layering

2. ddd/clean arch , layerd, works on abstrations, each layer only knows about the layer above
and it does it through abstractions not by talking to specific implementations

bounded context

works on contextual modeling for the domain

you can write software that is well aligned with the business


### TDD Naming conventions

The name should indicate the behaviour that we want to see from the system
