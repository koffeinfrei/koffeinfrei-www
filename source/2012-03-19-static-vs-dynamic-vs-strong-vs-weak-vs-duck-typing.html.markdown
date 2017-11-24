---
title: static vs dynamic vs strong vs weak vs duck typing
date: 2012-03-19 12:00:00 UTC
---

Here’s my take at clearing up the confusion about the most common type systems
used in programming.

I often hear how static and strong typing are used as synonyms. These two are
however quite different systems. The same applies to dynamic and weak typing.
For instance, a programming language can be both dynamically and strongly
typed, but not dynamically and statically. Ruby is an example of a dynamically
and strongly typed language.    
Ok, I guess now it’s the time to elaborate.

#### static vs dynamic

-   static: types are checked at compile time

<pre><code class="language-csharp">
  // example in c#

  string s = "asdf";
</code></pre>

-   dynamic: types are checked at runtime

<pre><code class="language-ruby">
  # example in ruby

  s = "asdf"
</code></pre>

#### strong vs weak

-   strong: types must match, only explicit conversion

<pre><code class="language-ruby">
  # example in ruby

  "1" + 1 # TypeError
</code></pre>

-   weak: implicit type conversion

<pre><code class="language-javascript">
  // example in javascript

  "1" + 1 // "11"
</code></pre>

#### duck typing

Duck typing is a style of dynamic typing.With duck typing, the set of methods
and properties determine the valid semantics of a class, instead of inheritance
from a specific class or implementation of an interface.    “When I see a bird
that walks like a duck and swims like a duck and quacks like a duck, I call
that bird a duck.”    This means that we actually don’t care if the class we’re
using is actually of a certain type, as long as it provides the methods or
properties we’re interested in.    
The term duck typing comes from python, but ruby is also very known for this
behaviour.
