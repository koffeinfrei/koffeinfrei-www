---
title: git bash prompt
date: 2013-07-05 05:43:00 UTC
---

Hi.

I tried many different bash git prompt solutions, all of which were either too
complicated, too buggy or too ugly. So…

I didn’t want to invent too much myself, so I used the [git prompt provided by
git](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh)
as a basis. This script does all the magic already, so the only thing left to
do was to make it look nicer. This is the whole section in my .bash\_profile:

```language-bash
# bash git prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="verbose"

git_current_branch_name="\$(__git_ps1 '%s' | sed 's/ .\+//' | sed -e 's/[\\\\/&]/\\\\\\\\&/g')"
git_status_substitutes=(
    "s/$git_current_branch_name//;" # remove branch temporarily
    "s/u//;" # upstream
    "s/+\([0-9]\+\)/▴\1/;" # outgoing
    "s/-\([0-9]\+\)/▾\1/;" # incoming
    "s/%/?/;" # untracked
    "s/+/✓/;" # staged
    "s/*/✕/;" # unstaged
    "s/\(.\+\)/($git_current_branch_name\1)/;" # insert branch again
)
git_status_command="\$(__git_ps1 '%s'| sed \"${git_status_substitutes[@]}\")"

if [ "$color_prompt" = yes ]; then
PS1="${debian_chroot:+($debian_chroot)}\[\033[0;37m\] \w \[\033[34m\]$git_status_command\[\033[37m\]\$\[\033[00m\] "
else
PS1="${debian_chroot:+($debian_chroot)} \w $git_status_command\$ "
fi
unset git_status_substitutes git_status_command git_current_branch_name
```

And now, step by step:

- Increase the detail level of the output of the script `__git_ps1`.

    ```language-bash
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="verbose"
    ```

- Extract the branch name. We’ll strip it out in order to make the symbol
  substitutions less fragile.

    ```language-bash
    git_current_branch_name="\$(__git_ps1 '%s' | sed 's/ .\+//;s/(//')"
    ```

- Define all substitutions that should be performed. This is the main part of
  my script, which substitutes the git prompt output with nicer utf-8
  symbols. “remove branch” first strips out the branch name and “insert
  branch” inserts it back after all other substitutions are done.

    ```language-bash
    git_status_substitutes=(
        "s/$git_current_branch_name //;" # remove branch temporarily
        "s/u//;" # upstream
        "s/+\([0-9]\+\)/▴\1/;" # outgoing
        "s/-\([0-9]\+\)/▾\1/;" # incoming
        "s/%/?/;" # untracked
        "s/+/✓/;" # staged
        "s/*/✕/;" # unstaged
        "s/\(.\+\)/($git_current_branch_name \1)/;" # insert branch again
    )
    ```

- Now we generate the command that will produce the desired output.
  `${git_status_substitutes[@]}` joins all symbol substitutions to one
  string.

    ```language-bash
    git_status_command="\$(__git_ps1 '%s'| sed \"${git_status_substitutes[@]}\")"
    ```

- Finally we construct two versions, one with colors and one without.

    ```language-bash
    if [ "$color_prompt" = yes ]; then
        PS1="${debian_chroot:+($debian_chroot)}\[\033[0;37m\] \w \[\033[34m\]$git_status_command\[\033[37m\]\$\[\033[00m\] "
    else
        PS1="${debian_chroot:+($debian_chroot)} \w $git_status_command\$ "
    fi
    ```

The final output looks like this:

```language-bash
~/src/dotfiles (master ✕✓? ▴1▾5)$
```

The original output of `__git_ps1` looks like this, which is much more cryptic:

```language-bash
~/src/dotfiles (master *+% u+1-5)$
```

The meaning of the symbols:

Symbol | Meaning
------ | -------
 ✕     | Unstaged changes
 ✓     | Staged changes
 ?     | Untracked files
 ▴1    | One changeset ahead of remote
 ▾5    | Five changesets behind remote
 =     | No difference to remote

You can see the whole thing in action in [my
.bash\_profile](https://github.com/koffeinfrei/dotfiles/blob/master/.bash_profile#L64-87).

## Update 2019-05-11

I extracted the bash and the git prompt to their own projects:

- [Git prompt for bash](https://github.com/koffeinfrei/bash-git-prompt)
- [Bash prompt](https://github.com/koffeinfrei/bash-prompt)
