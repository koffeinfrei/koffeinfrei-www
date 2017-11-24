---
title: useful linux commands
date: 2004-01-16 12:00:00 UTC
---

This is a random aggregation of useful linux commands.    
Useful for those who will be eventually stuck as I once was.    
Or those who didn’t know that certain things can be done in such a
smooth way…

#### Print a locked pdf

To be able to print a pdf file even though it has been print locked you
can convert the pdf to postscrloipt and back again to a pdf.

<pre><code class="language-bash">
$ pdf2ps locked.pdf unlocked.ps && ps2pdf unlocked.ps unlocked.pdf
</code></pre>

#### Mount a cd-rom image

This will mount an image file to a certain mountpoint such that it can
be used as a usual drive (like a virtual drive in windows).

<pre><code class="language-bash">
$ mount -o loop -t iso9660 &lt;isofilename&gt; &lt;mountpoint&gt;
</code></pre>

#### ssh with x-window support

With this you can launch an x-window application via an ssh connection
(provided that the host computer does support the particular toolkit).

<pre><code class="language-bash">
$ ssh -l &lt;loginname&gt; &lt;remote-host&gt; -X -C &lt;path-to-application&gt;
</code></pre>

#### Print out manpage

Prints out a manpage in a nicely formatted way.

<pre><code class="language-bash">
$ man &lt;manpage&gt; | col -b | ul -t dumb | lpr -P&lt;printername&gt;

$ man -Tps &lt;manpage&gt; | lpr -P&lt;printername&gt;
</code></pre>

#### Find advanced

Find is a very powerful command, as it is extensible in a very
convenient way.\
Every find-result is passed to “command”.

<pre><code class="language-bash">
$ find &lt;parameters&gt; -exec &lt;command '{}' ';'
</code></pre>

example 1, copies all jpg images to the folder “img/”

<pre><code class="language-bash">
$ find -name *.jpg -exec cp '{}' img/ ';'
</code></pre>

example 2, searches all textfiles for “searchstring”

<pre><code class="language-bash">
$ find -name *.txt -exec grep "searchstring" '{}' ';'
</code></pre>

#### Disable beep

If it’s about time to disable the annoying beep in the shell. For the
current user

<pre><code class="language-bash">
$ echo "set bell-style none"&gt;&gt; ~/.inputrc
</code></pre>

For all users (you have to be root) in `/etc/inputrc` set the line
`set bell-style none`

#### Convert a text file from [DOS]{.caps} to Unix style

This tool converts dos formatted text files with end-of-line `^M^J` to
unix end-of-line `^J`.

<pre><code class="language-bash">
$ dos2unix &lt;file
</code></pre>

#### Patch file

With the following command you create a patch file from any source file.

<pre><code class="language-bash">
$ diff -u src.old src.new1 &gt; file.patch0
</code></pre>

To apply the patch

<pre><code class="language-bash">
$ patch -p0 file &lt; file.patch0
</code></pre>

#### Convert a large file into small files

<pre><code class="language-bash">
$ split -b 650m file # split file into 650MB chunks

$ cat x* &gt; largefile # merge files into 1 large file
</code></pre>

#### Web page dump

The following will save the contents of a web page to a textfile.

<pre><code class="language-bash">
$ lynx -dump http://www.somesite.org/somepage.html &gt; textfile
</code></pre>

#### Clear file contents

In order to clear the contents of a file such as a logfile, do not use
rm to delete the file and then create a new empty file, because the file
may still be accessed in the interval between commands. The following is
the safe way to clear the contents of the file.

<pre><code class="language-bash">
$ :&gt;file-to-be-cleared
</code></pre>

#### Merge two PostScript or [PDF]{.caps} files

<pre><code class="language-bash">
$ gs -q -dNOPAUSE -dBATCH -sDEVICE=pswrite -sOutputFile=merge.ps -f file1.ps file2.ps

$ gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merge.pdf -f file1.pdf file2.pdf
</code></pre>

#### Samba client basics

Mount a windows (samba) share

<pre><code class="language-bash">
$ mount -t smbfs -o username=myname,uid=my_uid,gid=my_gid //server/share /mnt/smb

$ smbmount //server/share /mnt/smb -o "username=myname,uid=my_uid,gid=my_gid"
</code></pre>

List the shares on a computer

<pre><code class="language-bash">
$ smbclient -L 192.168.1.2
</code></pre>

Samba neighbors can be checked from Linux using the following command

<pre><code class="language-bash">
$ smbclient -N -L ip_address_of_your_PC | less

$ nmblookup -T "*"
</code></pre>

#### Make iso from cd

<pre><code class="language-bash">
$ dd if=/dev/cdrom of=image.iso
</code></pre>

#### Burn iso to cd

For an ide device

<pre><code class="language-bash">
$ cdrecord -v speed=SPEED dev=ATAPI:1,0,0 -data image.iso
</code></pre>

To find out the device number, use the following command

<pre><code class="language-bash">
$ cdrecord -scanbus dev=ATAPI
</code></pre>

Alternatively, you can specify the ide device directly

<pre><code class="language-bash">
$ cdrecord -v speed=SPEED dev=ATAPI:/dev/hdc -data image.iso
</code></pre>

For a scsi device

<pre><code class="language-bash">
$ cdrecord -v speed=SPEED dev=1,0,0 -data image.iso
</code></pre>

To find out the device number, use the following command

<pre><code class="language-bash">
$ cdrecord -scanbus
</code></pre>
