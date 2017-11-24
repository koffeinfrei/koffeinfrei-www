---
title: Proper modern old school ftp sync
date: 2015-07-27 20:20:00 UTC
---

Remember the old days when we had to upload our web page via ftp? I guess for
the php developers out there this is still the thing.  Developing ruby
applications and having capistrano and heroku and stuff has gotten me rid of
using ftp for years. But lately I started to use
[middleman](https://middlemanapp.com/) and that lamp server hosting I still
have sticking around got useful again. Without having ssh access to it, I was
again left with the (good) old ftp option. But as I remembered, syncing a web
page by ftp sucked. I used to do that all manually: either bluntly overwriting
or first removing and then newly upload everything, neither of which is very
elaborate. But then I found a proper solution for all this:
[lftp](http://lftp.yar.ru/). What I use now to properly sync a static middleman
page over ftp is this:

<pre><code class="language-bash">
lftp -e 'mirror -e -R local_directory remote_directory && exit' -u user_name ftp.your-domain.com
</code></pre>
