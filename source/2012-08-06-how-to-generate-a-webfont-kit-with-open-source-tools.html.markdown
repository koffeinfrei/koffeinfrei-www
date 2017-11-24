---
title: how to generate a webfont kit with open source tools
date: 2012-08-06 16:24:57 UTC
---

There are some web based services that convert fonts to a webfont package, the
most popular of which is the [fontsquirrel font-face
generator](http://www.fontsquirrel.com/fontface/generator). For our
[metaflop](http://www.metaflop.com) project I was looking for a service api
that i could call from within our application. Since i didn’t find one I was
attempting to build the whole webfont generation by collecting tools that could
do the job.

#### Font types

To create a webfont kit that works on all browsers we need to generate several
different font types:

-   [eot](http://en.wikipedia.org/wiki/Embedded_OpenType): IE
-   [woff](http://en.wikipedia.org/wiki/Web_Open_Font_Format): Modern
    Browsers
-   [ttf](http://en.wikipedia.org/wiki/TTF): Safari, Android, iOS
-   [svg](http://en.wikipedia.org/wiki/Scalable_Vector_Graphics): Chrome
    &lt; 4, Legacy iOS

#### Tool chain

The following tools are required to generate all the needed font types.  I
assume that you have your font as otf. If you have a ttf, just switch *ttf*
with *otf* in the following statements:

-   [FontForge](http://fontforge.sourceforge.net)    
    FontForge is primarily a visual outline font editor, but the tool
    [can also be
    scripted](http://fontforge.sourceforge.net/scripting-tutorial.html)
    and used on the command line.    
    Purpose: generates ttf, svg

The very simple FontForge script (*ttf-svg.pe*) looks like this:

<pre><code class="language-ruby">
Open($1)
Generate($1:r + ".ttf")
Generate($1:r + ".svg")
</code></pre>

<pre><code class="language-bash">
# outputs font.ttf, font.svg
$ fontforge -script ttf-svg.pe font.otf
</code></pre>

-   [sfnt2woff](http://people.mozilla.com/~jkew/woff)    
    Purpose: converts an otf to woff

<pre><code class="language-bash">
# outputs font.woff
$ sfnt2woff font.otf
</code></pre>

-   [ttf2eot](https://github.com/greyfont/ttf2eot)    
    Purpose: converts a ttf to eog

<pre><code class="language-ruby">
$ ttf2eot font.ttf > font.eot
</code></pre>

#### CSS

The css declaration is based on [Fontspring’s bulletproof @font-face
syntax](http://www.fontspring.com/blog/further-hardening-of-the-bulletproof-syntax)
and is the same syntax as used by fontsquirrel.

<pre><code class="language-css">
@font-face {
    font-family: 'YourFont';
    src: url('YourFont.eot'); /* IE 9 Compatibility Mode */
    src: url('YourFont.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('YourFont.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('YourFont.ttf') format('truetype'), /* Safari, Android, iOS */
         url('YourFont.svg#YourFont') format('svg'); /* Chrome < 4, Legacy iOS */
}
</code></pre>

That’s it. Remember though that you should only convert fonts are legally
eligible for web embedding.
