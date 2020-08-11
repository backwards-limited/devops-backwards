# Introduction

```bash
➜ echo $SHELL
/bin/zsh
```

![Bash prompt](images/bash-prompt.png)

Change the shell:

```bash
$ cat /etc/shells
# /etc/shells: valid login shells
/bin/sh
/bin/bash
/bin/rbash
/bin/dash
```

```bash
$ chsh
Password:
Changing the login shell for bob
Enter the new value, or press ENTER for the default
        Login Shell [/bin/bash]: /bin/sh
```

Now type in **su -** and your **userid** to relog in to verify that everything works correctly:

```bash
$ su - bob
Password:
$ echo $SHELL
/bin/sh
```

Then there's the **kernel**:

```bash
➜ uname
Darwin

➜ uname -r
19.6.0
```

![Customise bash prompt](images/customise-bash-prompt.png)

---

![Commands and arguments](images/commands-and-arguments.png)

---

![Command types](images/command-types.png)

---

![Pushd Popd](images/pushd-popd.png)

---

![Cat](images/cat.png)

There are also **pagers** such as **more** and **less** - note that **more** will load an entire file into memory, so not good for large files:

![Pagers](images/pagers.png)

---

![Long list](images/long-list.png)

---

![Help](images/help.png)

---

![Help](images/more-help.png)

---

![File types](images/file-types.png)

---

![File command](images/file-command.png)

---

![ls](images/ls.png)

---

![File system hierarchy](images/file-system-hierarchy.png)

