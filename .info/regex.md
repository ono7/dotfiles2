# regex python

## Atomic Groups for Engines that Don't Support It

```
Among the major engines, JavaScript and Python share the dubious distinction of
not supporting atomic grouping syntax, such as (?>A+)

This hack lets you get around it: (?=(A+))\1. The lookahead asserts that the
expression we want to make atomic—i.e. A+—can be found at the current position,
and the parentheses capture it. The back-reference \1 then matches it. So far,
this is just a long-winded way of matching A+. The magic happens if a token
fails to match further down in the pattern. The engine will not backtrack into a
lookaround, and for good reason: if its assertion is true at a given position,
it's true! Therefore, Group 1 keeps the same value, and the engine has to give
up what was matched by A+ in one block.

The page on Reducing (? … ) Syntax Confusion looked at two examples of atomic
groups. Referring to that page for what they do, here are the equivalent
"pseudo-atomic" groups in JavaScript and Python:

(?>A+)[A-Z]C translates to
(?=(A+))\1[A-Z]C

and

(?>A|.B)C translates to
(?=A|.B)\1C

```

```python
matchObj = re.search("^(?!OK|\\.)._", item)
# Don't forget to put ._ after negative look-ahead, otherwise you couldn't get any match ;-)
```

# re group naming

```python


import re

def money_from_string(amount):
  match = re.search(r'^\$(?P<dollars>\d+)\.(?P<cents>\d\d)$' , amount)
  if match is None:
      raise ValueError ( "Invalid amount: " + repr(amount))
      dollars = int(match.group( 'dollars' ))
      cents = int(match.group( 'cents' ))
  return Money(dollars, cents)
```

# modifiers

- Inline Modifier (?s) (re.DOTALL), (?i) = ignore case, (?m) = multiline

```
in newever versions of python in groups (?i:regex_pattern) to use inside groups

In .NET, PCRE (C, PHP, R…), Perl, Python and Java (but not Ruby), you can use
the inline modifier (?s), for instance in (?s)BEGIN .*? END. See the section on
inline modifiers for juicy details about three additional features (unavailable
in Python): turning it on in mid-string, turning it off with (?-s), or applying
it only to the content of a non-capture group with (?s:foo)
```

# greedy quantifiers

```
\w+   - + is a greedy quantifier, it matches as many
```

# lazy quantifiers (non-greedy)

```
* is a lazy quantifier
*? is lazy and matches as few as needed

123EEEE
Because the *? quantifier is lazy, \w*? matches as few characters as possible to
allow the overall match attempt to succeed, i.e. 123—and the overall match is
123E. For the match attempt that starts at a given position, a lazy quantifier
gives you the shortest match
```

# tempered dot (put guard rails on .)

```
When Not to Use this Technique For the task at hand, this technique presents no
advantage over the lazy dot-star .*?{END}. Although their logic differs, at each
step, before matching a character, both techniques force the engine to look if
what follows is {END}.

The comparative performance of these two versions will depend on your engine's
internal optimizations. The pcretest utility indicates that PCRE requires far
fewer steps for the lazy-dot-star version. On my laptop, when running both
expressions a million times against the string {START} Mary {END}, pcretest
needs 400 milliseconds per 10,000 runs for the lazy version and 800 milliseconds
for the tempered version.

Therefore, if the string that tempers the dot is a delimiter that we intend to
match eventually (as with {END} in our example), this technique adds nothing to
the lazy dot-star, which is better optimized for this job.

When to Use this Technique Suppose our boss now tells us that we still want to
match up to and including {END}, but hat we also need to avoid stepping over a
{MID} section, if it exists. Starting with the lazy dot-star version to ensure
we match up to the {END} delimiter, we can then temper the dot to ensure it
doesn't roll over {MID}:

{START}(?:(?!{MID}).)*?{END} If more phrases must be avoided, we just add them
to our tempered dot: {START}(?:(?!{MID})(?!{RESTART}).)*?{END} This is a useful
technique to know about.
```

# when its ok to use `.*` greedy match

```
✽ Trust the Dot-Star to Get You to the End of the Line
With all the admonishments against the dot-star, here is one of many cases where
it can be useful. In a string such as @ABC @DEF, suppose you wish to match the
last token that starts with @, but only if there is more than one token. If you
simply wanted the last, you could use an anchor: @[A-Z]+$… but that will match
the token even if it is the only one in the string. You might think to use a
lookahead: @[A-Z].*\K@[A-Z]+(?!.*@[A-Z]). However, there is no need because the
greedy .* already guarantees you that you are getting the last token! The
dot-star matches all the way to the end of the line then backtracks, but only as
far as needed: You can therefore simplify this to @[A-Z].*\K@[A-Z]+ Trust the
dot-star to take you to the end of the line!
```

# regex greedy + does not backtrack when using negated character possesive/atomic

An Alternative to Laziness
In this case, there is a better option than making the plus lazy. We can use a
greedy plus and a negated character class: <[^>]+>. T

```
* atomic group mimic within non capture group

(?s)^line vty 0 4(?:(?=(.*?timeout 15))\1)

(?s)^line vty 5 15(?:(?=(.*?timeout 15.*?password \S+))\1)


# second lookahead will only get processed if the named group one hits
# this is the official way to mimik a atomic group in python

(?s)^line vty 0 4(?=(?P<tmp>.*?timeout 15))(?P=tmp).*?(?=(?:line|^$))
(?s)^line vty(?=(?P<tmp>.*?))(?P=tmp).*?(?=(?:line|^$))

# match all non matches
(?s)(?=(?P<tmp>^line vty.*?(?:(?=line|^$))))(?P=tmp)

```
