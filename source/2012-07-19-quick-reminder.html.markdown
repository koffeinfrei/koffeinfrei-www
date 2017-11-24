---
title: reminder. git. awesome.
date: 2012-07-19 16:02:00 UTC
---

This is just a quick reminder of how awesome git actually is. The story is
short:

My disk crashed and I lost a couple of local commits that I hadn’t pushed (to
github) yet. Luckily, I deployed them to the staging server already (actually,
this is a reminder of how awesome git *and* capistrano actually are). Because
capistrano is awesome and deploys the git repo to the server, and git is
awesome too, I could restore my local repo from the staging server:

<pre><code class="language-bash">
local:  $ ssh staging_server
server: $ # some `cd` action
server: $ tar czf asdf.tgz www_folder
server: $ # ctrl + D
local:  $ cd /tmp
local:  $ scp user@staging_server:/tmp/asdf.tgz .
local:  $ tar xf asdf.tgz
local:  $ cd my_local_repo
local:  $ git pull /tmp/asdf dev
</code></pre>

A simple `git pull` from the copied repo and I’m all set again.

How awesome is your dev stack?
