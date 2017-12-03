---

title: Rails 5, Turbolinks 5 and form errors
date: 2017-12-03 12:48 UTC
tags: 

---

I was one of those Rails developers that avoided Turbolinks at all costs. I
even removed it from a lot of existing applications. The new Turbolinks with
Rails 5 though was said to be a lot better (I read some blog post about it, but
I don't remember which one exactly). I gave it another spin in my latest
project.

It all went pretty well, but then I noticed that for forms it actually was not
working as expected, as reflected in [issue
85](https://github.com/turbolinks/turbolinks/issues/85#issuecomment-298347900):

> When you submit a form that has errors, Rails normally renders the new action
> again with the form and the errors. With Turbolinks as it is setup right now,
> the redirects are handled nicely, but this piece requires you to build your
> own create.js.erb response to render the errors.

So Turbolinks does not automatically render form errors. I was not keen at all
to handle something Rails takes care of so nicely by myself. After trying out
the various solutions in the above mentioned issue I was going for a modified
version of [minimul's
solution](https://github.com/turbolinks/turbolinks-rails/pull/20#issuecomment-301462365).

<pre><code class="language-ruby">
def render_with_turbolinks(*options, &block)
  html = render_to_string(*options, &block)

  script = <<-SCRIPT
    (function(){
      Turbolinks.clearCache();
      var doc = document.implementation.createHTMLDocument('response');
      doc.documentElement.innerHTML = "#{ActionController::Base.helpers.j(html)}";
      document.documentElement.replaceChild(doc.body, document.body);
      Turbolinks.dispatch('turbolinks:load');
      window.scroll(0, 0);
    })();
  SCRIPT

  self.status = 200
  self.response_body = script
  response.content_type = 'text/javascript'
end
</code></pre>

I preferred that solution over the other suggested ones as it is the least
intrusive.

* Only requires to use `render_with_turbolinks` instead of the normal `render`
  method in the controller
* No update to the view needed
* No additional JavaScript code
* Doesn't modify any global events

The one thing I modified was using `document.implementation.createDocument`
instead of `DOMParser`, as this feature is not supported in PhantomJS (See
[HTML to
DOM](https://developer.mozilla.org/en-US/docs/Archive/Add-ons/Code_snippets/HTML_to_DOM)
for more information on this).

With this addtition Turbolinks 5 worked out very well for my newest project.
The application feels snappy like an
[SPA](https://en.wikipedia.org/wiki/Single-page_application), while we were
able to use the still very comfortable Rails stack.
