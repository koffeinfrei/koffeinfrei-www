---

title: Replace PhantomJS by headless Firefox (for Capybara)
date: 2017-12-22 17:38 UTC
tags: 

---

## Background

PhantomJS has been the number one tool for automated testing for myself and for
many other developers. After the announcement of Headless Chrome PhantomJS's
chief developer announced that [he would be stepping down as
maintainer](https://groups.google.com/forum/#!topic/phantomjs/9aI5d-LDuNE).

> Headless Chrome is coming [...] 
> 
> I think people will switch to it, eventually. Chrome is faster and more stable than PhantomJS. And it doesn't eat memory like crazy.
> 
> I don't see any future in developing PhantomJS. [...]

Following this announcement a lot of projects started switching to Headless
Chrome, [including
GitLab](https://about.gitlab.com/2017/12/19/moving-to-headless-chrome/).

Technically there's nothing wrong with that, but I suggest you take a minute to
consider using Firefox instead of Chrome. The reason for using Firefox is
because Mozilla is a non profit organization who's [mission is to keep the
Internet growing and healthy](https://www.mozilla.org/en-US/mission/). Google
on the other hand is a tech company that has its focus on making profit and
protecting and growing its business.

The question we need to ask ourselves is which one of these companies is more
likely to act in the interest of a free and sustainable internet.

Please go ahead and read the Wired article [Firefox thinks Quantum can beat
Chrome with ethics… and
speed](http://www.wired.co.uk/article/mozilla-firefox-quantum-browser-vs-google-chrome)
and [Mozilla's Internet
Health](https://www.mozilla.org/en-US/internet-health/).

But enough of the politics already. Let's get to the technicalities.

## Solution

Add the following two gems to your Gemfile. `geckodriver-helper` is optional,
but it's really useful as it installs the required geckodriver binary and you
don't need to depend on the environment to have it installed.

<pre><code class="language-ruby">
gem 'geckodriver-helper'
gem 'selenium-webdriver'
</code></pre>

Register a new cabybara driver. This usually resides in the `spec_helper.rb` or
`rails_helper.rb` for a Ruby on Rails project.

<pre><code class="language-ruby">
Capybara.register_driver :firefox_headless do |app|
  options = ::Selenium::WebDriver::Firefox::Options.new
  options.args << '--headless'

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.javascript_driver = :firefox_headless
</code></pre>

In case you're using
[capybara-screenshot](https://github.com/mattheworiordan/capybara-screenshot)
you need to add the following line as well:

<pre><code class="language-ruby">
# From https://github.com/mattheworiordan/capybara-screenshot/issues/84#issuecomment-41219326
Capybara::Screenshot.register_driver(:firefox_headless) do |driver, path|
  driver.browser.save_screenshot(path)
end
</code></pre>

That's pretty much all there is to do. What's left is fixing the specs that
start failing due to the differences between Poltergeist and Selenium. I
suggest reading about the differences on the blogpost [How GitLab switched to
Headless Chrome for
testing](https://about.gitlab.com/2017/12/19/moving-to-headless-chrome/)

## Benchmark

Would you like some random benchmark numbers? Sure. Here's a comparison on a
random (rather small) project with a test suite containing 167 features specs.

| Driver                  | Elapsed time  | Memory used |
| ----------------------- | -------------:| -----------:|
| Firefox headless        | 2:08.49       | 292 MB      |
| Chrome headless         | 1:32.29       | 297 MB      |
| PhantomJS (Poltergeist) | 1:20.74       | 310 MB      |

I hate to admit it. Firefox is slower. Around 40% slower. So there you have it.

Memory consumption is about the same for all of them.

## Final words

That's the end of this post. Thanks for making it this far.

Make sure to read the extensive blog post by GitLab [How GitLab switched to
Headless Chrome for
testing](https://about.gitlab.com/2017/12/19/moving-to-headless-chrome/) which
contains a lot of valuable details about switching away from PhantomJS.
