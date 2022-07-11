---

title: Git cleanup-branches
date: 2022-07-11 16:47 UTC
tags:

---

Additionally to the existing [`git squash` and `git
fixup`](/2018/09/22/git-fixup-and-git-squash/) I added another piece in my
custom git toolbox fitting in with the [git fixup
workflow](/2018/09/18/the-git-fixup-workflow/):

[git cleanup-branches](https://github.com/koffeinfrei/dotfiles/blob/master/bin/git-cleanup-branches)

This one is especially useful if you work in a team and work with pull / merge
requests, and need to once in a while clean up the branches in your local
repository.

The script consists of 3 steps:

1. **Prune remote branches**<br>
   This means that all branches which don't exist in the remote repository
   anymore are also deleted locally
2. **Remove merged branches**<br>
   Branches that have been merged to the default branch (i.e. `main` or
   `master`) are deleted. This is useful if you previously merged a PR / MR.
3. **Remove branches from other authors**<br>
   This step removes branches that don't have any commits by you. This usually
   happens when you checked out a branch by someone else, possibly to review
   their work.

A sample session could look like this:

```language-bash
 ~/src/example ⑂ main ? = ➜ git cleanup-branches
No local changes to save
Already on 'main'
Your branch is up to date with 'origin/main'.
🥁 Pruning remote branches...
Fetching origin
From github.com:koffeinfrei/example
 - [deleted]            (none)    -> origin/fix/weird-stuff
 - [deleted]            (none)    -> origin/feat/nice-stuff

🥁 Removing merged branches...
Deleted branch feature/feat/nice-stuff (was fee237764).

🥁 Removing branches from other authors...
You don't seem to have any commits in the branch ⑂ feature/docs/add-deployment-section

 * 91e8d233a 2022-07-05 Document deployment (feature/docs/prompt-for-sw-updates) [Gob Bluth]

Delete the branch 'feature/docs/prompt-for-sw-updates'? (y/n)? y
Deleted branch feature/docs/prompt-for-sw-updates (was 91e8d233a).

Already on 'main'
Your branch is up to date with 'origin/main'.
```

The source code is available [on
GitHub](https://github.com/koffeinfrei/dotfiles/blob/master/bin/git-cleanup-branches).
