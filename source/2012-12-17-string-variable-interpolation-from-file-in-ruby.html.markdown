---
title: string variable interpolation from file in ruby
date: 2012-12-17 12:51:00 UTC
---

Sometimes you want to interpolate your variables from a dynamic string, e.g.
some settings from a yaml file. The top three options are:

-   use `eval()` to interpolate the variables in the form of `#{foo}`
-   use some templating engine like erb or mustache or whatever
-   use the string format operator

I’ll show the third option here as:

-   `eval()` is dangerous for externally read sources and the yaml needs
    to be aware of the variables and scopes where the string is
    interpolated in the source code
-   a templating engine is overkill for this purpose

Ruby has [string formatting support](http://apidock.com/ruby/Kernel/sprintf)
and a very handy [%](http://apidock.com/ruby/String/%25) operator. This enables
us to replace certain parts of our config at runtime with the actual value,
like this:

<pre><code class="language-ruby">
"foo = %{foo}" % { :foo => 'bar' }
</code></pre>

[Metaflop](http://www.metaflop.com) serves once again as a sample application.
The following shows the perl command to generate some parts of our fonts
(simplified):    
config.yml:

<pre><code class="language-ruby">
font_otf: perl mf2pt1.pl --family=%{fontface} --nofixedpitch --fullname="%{fontface} %{font_hash}" font.mf
</code></pre>

Assuming we have a “config” variable that holds all the values defined
in yaml we can do:

<pre><code class="language-ruby">
config.font_otf % {
  :fontface =&gt; 'Bespoke',
  :font_hash =&gt; '234sdof23nsf'}

# => perl mf2pt1.pl --family=Bespoke --nofixedpitch --fullname="Bespoke 234sdof23nsf" font.mf
</code></pre>

The operator accepts literals and arrays as arguments as well, but I
like the named parameters style best. This way, there is an obvious
connection between the placeholder and its value.
