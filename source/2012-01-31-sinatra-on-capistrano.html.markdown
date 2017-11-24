---
title: sinatra on capistrano
date: 2012-01-31 12:00:00 UTC
---

Capistrano is really great for deployment. The documentation however is
somewhat scattered. The [capistrano
wiki](https://github.com/capistrano/capistrano/wiki) has a more or less useful
[From The
Beginning](https://github.com/capistrano/capistrano/wiki/2.x-From-The-Beginning)
instruction and a [Getting
Started](https://github.com/capistrano/capistrano/wiki/2.x-Getting-Started)
that doesn’t quite get you started.    
However, the [instructions on
github](http://help.github.com/deploy-with-capistrano/) are actually a very
good starting point. Neverthelesse I want to show my sample here that has two
additions to the one in the github help.

1.  Multistage support (i.e. staging and production server)
2.  Custom task to upload a config file

For further reading I recommend the [Capistrano
Handbook](https://github.com/leehambley/capistrano-handbook/blob/master/index.markdown).

I assume that you’ve setup capistrano as described in the github help.  The one
thing I suggest is to ignore the part where the password is stored in the file.
I highly advise to use ssh agent forwarding instead.

<pre><code class="language-ruby">
ssh_options[:forward_agent] = true # use local ssh key
set :user, "deployer"
</code></pre>

Let’s setup multistage:

<pre><code class="language-ruby">
require 'capistrano/ext/multistage'
set :stages, %w(production staging)
set :default_stage, "staging"
</code></pre>

Also, on most deployment server you may not have rights to sudo:

<pre><code class="language-ruby">
set :use_sudo, false
</code></pre>

As I’m assuming you’re using passenger mod\_rails:

<pre><code class="language-ruby">
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
</code></pre>

The last part uploads our configuration file to the server. This configuration
contains user and password for the database login. We don’t store that in the
source code repository.

<pre><code class="language-ruby">
namespace :config do
  task :db do
    upload('db.yml', "#{deploy_to}/current/db.yml")
  end
end

before "deploy:restart", "config:db"
</code></pre>

The [whole capistrano configuration
file](https://github.com/greyfont/metaflop-www/blob/master/config/deploy.rb)
is on github.
