---
title: fuzzy file matching in vim
date: 2013-12-13 22:47:00 UTC
---

Until recently I used [command-t](https://wincent.com/products/command-t
"command-t") as the mechanism for opening files. It was always working great
for me, and apart from the installation, which is a bit of a hassle because
it’s written in ruby, I was very happy with it. There was only one feature
missing: Word boundary matching by using uppercase characters.

I was playing with the thought of contributing that feature to command-t, but
then [Gary Bernhardt](https://www.destroyallsoftware.com/) came along and put
[selecta](https://github.com/garybernhardt/selecta) out there:

> A fuzzy text selector for files and anything else you need to select.

He even provides a simple script that provides fuzzy file matching in vim.

So… let’s extend that really nice and simple script with my desired word
boundary matching, I thought. And [I did exactly
that](https://github.com/koffeinfrei/selecta/tree/word-boundary-match).

What my extension does is this:

> Uppercase characters in the query must match a word boundary. Word boundaries
> are pascal and camel cased words and the characters ‘/’, ‘\\’, ‘\_’, ‘-’, ‘.’
> and whitespace. (“FooB” will match “foo/bar” and “fooBar” but not “foobar”)

For the use case of fuzzy file matching in vim the change allows to search very
quickly for specific paths. If we want to search e.g. for a rails model named
foo, we could enter “AMFoo”, which would match the path “app/models/foo.rb”,
but not “app/controllers/myfoos\_controller”.  If we searched just for “amfoo”,
the latter would be matched as well.
