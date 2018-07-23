---

title: Ruby serialization benchmark
date: 2018-03-21 16:07 UTC
tags: 

---

## TL;DR

Always use [OJ](http://www.ohler.com/oj/) for serialization (unless you're
using JRuby).

## The longer version

The out-of-the-box solution for serialization in ruby is either the built-in
[JSON](http://ruby-doc.org/stdlib-2.5.0/libdoc/json/rdoc/JSON.html) or the
binary [Marshal](http://ruby-doc.org/core-2.5.0/Marshal.html) format. The
former has the advantage that it's a human readable,
[standardized](https://tools.ietf.org/html/rfc8259) and universal format, while
the Marshal format is specific to ruby and not very human readable.

I was under the impression that the choice between those two was a decision
between JSON and fast. For ruby's core and standard library this is certainly
true. But let's have a closer look at the alternatives.


### Standard types

<pre><code class="language-shell">
--> Benchmarking an object of type Hash

     JSON (using oj):       68.3 i/s
         MessagePack:       62.7 i/s - 1.09x   slower
                BSON:       54.7 i/s - 1.25x   slower
             Marshal:       41.4 i/s - 1.65x   slower
   JSON (using Yajl):       31.3 i/s - 2.18x   slower
JSON (built-in ruby):       26.9 i/s - 2.54x   slower
                YAML:        1.2 i/s - 59.15x  slower
</code></pre>

<pre><code class="language-shell">
--> Benchmarking an object of type String

     JSON (using oj):      344.6 i/s
                BSON:      308.3 i/s - 1.12x   slower
             Marshal:      151.1 i/s - 2.28x   slower
         MessagePack:      127.8 i/s - 2.70x   slower
JSON (built-in ruby):       99.2 i/s - 3.47x   slower
   JSON (using Yajl):       96.9 i/s - 3.55x   slower
                YAML:        4.7 i/s - 74.01x  slower
</code></pre>

<pre><code class="language-shell">
--> Benchmarking an object of type Float

                BSON:      332.6 i/s
     JSON (using oj):      204.1 i/s - 1.63x   slower
             Marshal:      168.1 i/s - 1.98x   slower
         MessagePack:      124.3 i/s - 2.68x   slower
JSON (built-in ruby):       83.8 i/s - 3.97x   slower
   JSON (using Yajl):       80.2 i/s - 4.15x   slower
                YAML:        4.5 i/s - 73.27x  slower
</code></pre>

So far OJ and [BSON](http://bsonspec.org) are the fast ones.


### Any type

When evaluating a serializer it's important that it's a general purpose
serializer, meaning that it can handle an arbitrary type without the need of
modifying it. Most of the benchmarked serializers are eliminated by this
requirement. The
[stereobooster/ruby-json-benchmark](https://github.com/stereobooster/ruby-json-benchmark)
repository provides a nice overview of the capabilities of the different json
implementations.

The next benchmark iteration focuses on the two fastest ones that can handle
all types.

<pre><code class="language-shell">
--> Benchmarking an object of type Float

     JSON (using oj):      198.8 i/s
             Marshal:      169.1 i/s - 1.18x  slower
</code></pre>

<pre><code class="language-shell">
--> Benchmarking an object of type Hash

     JSON (using oj):       70.9 i/s
             Marshal:       44.4 i/s - 1.60x  slower
</code></pre>

<pre><code class="language-shell">
--> Benchmarking an object of type String

     JSON (using oj):      368.0 i/s
             Marshal:      158.3 i/s - 2.33x  slower
</code></pre>

<pre><code class="language-shell">
--> Benchmarking an object of type CustomClass

     JSON (using oj):      195.2 i/s
             Marshal:       87.4 i/s - 2.23x  slower
</code></pre>

Serializing a custom type is more than twice as fast with OJ than it is with
Marshal.


## Conclusion

Unless you are on JRuby I'd always use [OJ](http://www.ohler.com/oj/). It is
overall the fastest implementation and also provides the convenience of JSON.
Additionally, if you're using Ruby on Rails, you can use [OJ as a drop in
replacement](https://github.com/ohler55/oj/blob/master/pages/Rails.md) for the
standard implementation.


## Notes

The benchmarks were made using
[benchmark-ips](https://github.com/evanphx/benchmark-ips) on a Lenovo X1
Carbon, Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz, 16GB DDR3 RAM, running Ubuntu
and running with ruby 2.5.0. Each iteration is performing a serialization and a
subsequent deserialization.

The whole benchmark code is available [as a
gist](https://gist.github.com/koffeinfrei/44a2782a28c5a935574c2df4e72490c0).
