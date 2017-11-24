---
title: linux and skype and misery and happiness
date: 2013-09-28 12:00:00 UTC
---

(Preamble: this guide applies to ubuntu)

Ok so there was a time when the appeal of Skype’s linux version lied in the
lack of features and fancy ui. It was stable and my life was awesome.

Then new versions were released and new features were added. Some day Microsoft
joined the party (not necessarily concluding that Skype’s change for the worse
has something to do with them). Somewhere between then and now Skype became a
real imposition for my life. Random crashes on chat, permanent crashes on
calls. I gave up on it, using solely my android’s version for calls.

Once upon a time, which is now, I gave it another shot, crawled the internet
for solutions and [found the
following](http://community.skype.com/t5/Linux/Skype-silently-crashes-on-Ubuntu/m-p/706137/highlight/true#M4052):

-   Don’t use the official version that can be downloaded from their
    website
-   Do this instead:
    <pre><code class="language-bash">
    $ sudo apt-get remove --purge skype
    $ sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    $ sudo apt-get install skype
    </code></pre>

Now the ugly task indicator is back and everything is stable again.
