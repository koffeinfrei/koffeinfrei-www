---
title: ruby blood through your .net veins with a vengeance
date: 2008-06-28 12:00:00 UTC
---

In [my last blog entry](/2008/04/07/ruby-blood-through-your-net-veins) i
totally neglected the fact that there are [lamda
expressions](http://msdn.microsoft.com/en-us/library/bb397687.aspx).
This nice little [C\# 3.0
feature](http://msdn.microsoft.com/en-us/library/bb308966.aspx#csharp3.0overview_topic22)
makes [anonymous
methods](http://msdn.microsoft.com/en-us/library/0yw3tz5k(VS.80).aspx)
much more readable. With that in mind, we can make our `Times` method
much nicer.

## Example 1: Ruby style iterator with lambda expression

<pre><code class="language-csharp">
2.Times( number =&gt; { Console.WriteLine("&gt; " + number); } ); 
</code></pre>

Compared to the former syntax, it increases readability considerably.

## Example 2: Ruby style iterator with bare delegate

<pre><code class="language-csharp">
2.Times( 
    delegate(int number)   
    {     
        Console.WriteLine("&gt; " + number);   
    }
);
</code></pre>
