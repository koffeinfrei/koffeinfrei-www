---
title: sinatra with bourbon
date: 2012-03-24 20:39:00 UTC
---

If you search the web for “bourbon sinatra” you get a whole lot about Frank
Sinatra and his drinking habits. But that’s not what this post is about.

How to use [bourbon scss mixins](https://github.com/thoughtbot/bourbon) with
[sinatra](www.sinatrarb.com) is not documented on their project page. So here’s
my short setup.

The following is standard, from their documentation.

<pre><code class="language-bash">
$ gem install bourbon # or better, add to your Gemfile and use bundler
$ cd views/scss
$ bourbon install
</code></pre>

Next, import bourbon in your main scss file (as first statement).

<pre><code class="language-ruby">
@import 'bourbon/bourbon';
</code></pre>

The following is the important and the undocumented part, specifically
for sinatra. You need to require the ruby libraries in your scss route.

<pre><code class="language-ruby">
get '/assets/css/:name.scss' do |name|
  require './views/scss/bourbon/lib/bourbon.rb'
  content_type :css 
  scss name.to_sym, :layout => false
end
</code></pre>
