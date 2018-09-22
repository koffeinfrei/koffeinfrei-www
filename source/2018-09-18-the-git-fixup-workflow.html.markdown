---

title: The Git fixup workflow
date: 2018-09-18 06:58 UTC
tags:

---

> This post first appeared on the Panter Blog:
>
> [blog.panter.ch/2018/09/18/the-git-fixup-workflow.html](https://blog.panter.ch/2018/09/18/the-git-fixup-workflow.html)

## Introduction

The [GitHub flow](https://guides.github.com/introduction/flow/), or a similar
Git strategy where the main work is done on feature branches which result in
pull or merge requests, has become the standard way to work with Git and GitHub
or GitLab (or Bitbucket even) for many developer teams. Besides the main
advantages of this way of working it also enables developers to keep a clean
Git history (see also [5 rules to Git
better](https://blog.panter.ch/2016/08/31/5-rules-to-git-better.html)).

Let's assume the following as a starting point for the suggested workflow in
this post:

- You want to maintain a clean Git history, meaning that fix commits should be
  avoided
- You don't want to interrupt your development workflow by having to rewrite
  your Git history all the time
- You can use `git commit --amend` only for the latest commit

Git has some powerful commands that allow us to both keep a clean history and
not having to interrupt our development workflow. We'll call it "the Git fixup
workflow".

## The linear workflow

To illustrate the Git fixup workflow, we'll use the following example hack
session:

<pre><code class="language-shell">
# coding the user component's index view

$ git commit -m "add user component's index view"

# coding the user component's edit view

$ git commit -m "add user component's edit view"

# updating the component's index view so it actually works

$ git commit -m "add user component's index view, it works now"

# a typo is noticed in the index view

$ git commit -m "fix typo in index view"

# fix a bug in the view rendering

$ git commit -m "fix view rendering"

$ rubocop
$ yarn lint

# fix linting errors

$ git commit -m "fix linting errors"

# team members do a code review on the PR / MR

$ git commit -m "fix import in index"
</code></pre>

The above session leads to the following Git history:

<pre><code class="language-markup">
fix import in index
fix linting errors
fix view rendering
fix typo in index view
add user component's index view, it works now
add user component's edit view
add user component's index view
</code></pre>

The following commits reflect the actual work that's relevant from another
developer's standpoint:

<pre><code class="language-markup">
fix view rendering
add user component's edit view
add user component's index view
</code></pre>

All commits that amend a previous commit just clutter the history and should be
squashed. The commit "fix typo in index view" for example should be squashed
together with "add user component's index view".

To clean up the history, we could manually interactively rebase the commits
before merging the branch. Imagine though that you may have many commits
and later in the process, you won't remember which ones should be squashed
together. Also, it's a lot of manual work to mark the relevant commits in the
interactive rebase mode.

## The fixup workflow

Git includes everything required to automate this. So let's redo the previous
hack session with our new toolset:

<pre><code class="language-shell">
# coding the user component's index view

$ git commit -m "add user component's index view"

# coding the user component's edit view

$ git commit -m "add user component's edit view"

# updating the component's index view so it actually works

$ git commit --fixup &lt;COMMIT HASH OF THE COMMIT "add user component's index view"&gt;

# a typo is noticed in the index view

$ git commit --fixup &lt;COMMIT HASH OF THE COMMIT "add user component's index view"&gt;

# fix a bug in the view rendering

$ git commit -m "fix view rendering"

$ rubocop
$ yarn lint

# fix linting errors, assuming the linting error was introduced in the commit
# "add user component's edit view"

$ git commit --fixup &lt;COMMIT HASH OF THE COMMIT "add user component's edit view"&gt;

# team members do a code review on the PR / MR

$ git commit --fixup &lt;COMMIT HASH OF THE COMMIT "add user component's index view"&gt;
</code></pre>

The resulting Git log looks like this:

<pre><code class="language-markup">
fixup! add user component's index view
fixup! add user component's edit view
fix view rendering
fixup! add user component's index view
fixup! add user component's index view
add user component's edit view
add user component's index view
</code></pre>

Instead of regularly committing (and also writing a commit message) we use the
`--fixup` flag to create fixup commits.

Now, before merging the merge request, we issue an interactive rebase with the
`--autosquash` flag.

> **Note:**
> GitLab marks MRs that include fixup commits as `WIP`, so merging is
> prevented if you haven't squashed.

<pre><code class="language-shell">
$ git rebase --interactive --autosquash \
  &lt;COMMIT HASH OF THE COMMIT "add user component's index view"&gt;~1
</code></pre>

We'll enter interactive rebase mode with the relevant commits already marked
for fixup:

<pre><code class="language-markup">
pick 364003b add user component's index view
fixup afa6970 fixup! add user component's index view
fixup 1da5d7c fixup! add user component's index view
fixup c998b08 fixup! add user component's index view
pick d9731b5 add user component's edit view
fixup 33d6080 fixup! add user component's edit view
pick 73e8a6a fix view rendering
</code></pre>

The resulting Git history looks like this:

<pre><code class="language-markup">
fix view rendering
add user component's edit view
add user component's index view
</code></pre>

The final result is a very consistent and readable Git history, where every
other developer knows what happens, without the uninteresting sidesteps you
took while developing.

## Summary

In summary, the following two essential Git commands are necessary to make use
of the Git fixup workflow:

<pre><code class="language-shell">
$ git commit --fixup &lt;COMMIT THAT NEEDS FIXING&gt;
$ git rebase -i --autosquash &lt;FIRST COMMIT THAT NEEDS FIXING&gt;~1
</code></pre>

## Bonus: Create Git aliases

If you start adopting this workflow, you'll have to type a lot in your terminal.
At this point it makes sense to create some Git aliases to ease your brain and
hands.

<pre><code class="language-markup">
[alias]
    cif = commit --fixup
    ri = rebase -i --autosquash
</code></pre>

## More bonus: Global autosquash config

Instead of having to provide the `--autosquash` flag the configuration can be
applied globally. The rebase command still requires `-i` though.

<pre><code class="language-shell">
$ git config --global rebase.autoSquash true
</code></pre>

## Edit (2018-09-18)

I wrote two git scripts `git fixup` and `git squash` to support this workflow
and added a [blog post describing them](/2018/09/22/git-fixup-and-git-squash/).
