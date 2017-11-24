---
title: too many parameters?
date: 2006-10-06 12:00:00 UTC
---

Today I came across an interesting fact about java (referring to the
programming language, not the island). But first things first. You may not be
interesting in the previous history but I’ll tell it anyway.    During my
diploma work (that will be finished in one week by the way) I had to generate
some classes invoking the wsdl2java parser. I won’t explain what that parser is
about. Anyway, I invoked the parser on the amazon web service which got me an
interesting error.  `ItemAttributes.java:538: too many parameters`. So I
counted them and I got 261 arguments. That made me wonder how many arguments
were actually allowed for a method in java. I searched the java forums and
mailinglist and found the answer in the [Java Virtual Machine
Specification](http://java.sun.com/docs/books/vmspec/2nd-edition/html/ClassFile.doc.html#88659).
The following summarizes the facts I was interested in.

> Java limits the number of method parameters to 255 or 254 or less if
parmeters are of type long or double. The 255 method parameter limit is for
static methods and 254 for non static methods.

And some more limitation facts for that matter.

-   method bytecode: 65,535 bytes
-   local variables: 65,535 (each long or double counts as two
    variables)
-   fields: 65,535 (does not include inherited fields)
-   methods: 65,535 (does not include inherited methods)
-   method parameters: 255 (each long or double counts as two
    parameters)

I hope that no programmer will ever get even close to those limits.  Otherwise
the class design should definitely be reconsidered. Anyway, I’m positive that
I’m not going to ever see a method that has more parameters than this one…
