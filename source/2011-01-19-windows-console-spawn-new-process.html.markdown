---
title: 'windows console: spawn new process'
date: 2011-01-19 12:00:00 UTC
---

Under linux spawning a new process is as easy as appending an `&` to the
command. In windows it’s not (obviously). I pretty quickly found out about the
`start` command. Not as elegant as the linux version, but still pretty
intuitive. Or, wait, not? It took me half a decade to find out how to use it
properly.

First i had a look at the help output, which can be invoked by the switch `/?`.
I’m not 100% sure, but i have in mind that this switch isn’t really
standardized, i think I also had to use `/h` or `/help` in the past. Anyway,
that’s not the sad part yet.

![console
start](2011-01-19-windows-console-spawn-new-process/console-start.png "console start")

Reading through that, all you have to do is call `start my_command`.    
Easy huh? No. It’s not.

After digging around [this article](http://ss64.com/nt/start.html) lead me to
the solution: “title: Text for the CMD window title bar (required)”.
Title! Required!    
Let me say that again. Title! Required!    
First thought: Why?
Why is a title required? A title is clearly something optional, especially when
you’re starting a GUI application.    
Second thought: Why? Why is that “required” not stated as such in the help
output? Not the slightest hint in the help output. And furthermore, isn’t it a
convention that required parameters are NOT surrounded by brackets? Don’t
brackets mean “optional”?  Apparently, in the windows tooling environment all
this does not apply.

I know, windows is a GUI centered OS, and therefore the console didn’t evolve
as nicely as it did in other OS’s. Nevertheless, every time I have to work on a
console or write a batch file it gives me the creeps. Everything is so
unbelievably clumsy. At least I found out about the [Console
project](http://sourceforge.net/projects/console/), which is a pretty decent
replacement for the windows console. Copy/paste works as desired with keyboard
shortcuts and you can resize the window. Resize the window! How cool is that!
But that’s a different story…
