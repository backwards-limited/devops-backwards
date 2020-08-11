# GIT

![Git](images/git.png)

NOTE **-u** is required only for first **push** of **master** when master initially does not exist in the remote repository.

If someone else was to **clone** the repo:

```bash
git clone https://github.com/mmumshad/my-application.git
```

the repo **name** will initially default to **origin**. Why care about **name** e.g. that we initially provided a name of **github**? Well, source code (locally) can be pushed to multiple remote repositories, and in that case we have to identify where to **push** to and **pull** from e.g.

```bash
git push github master
OR
git push gitlab master
```

We can see the default name:

```bash
git remote -v

origin https://github.com/mmumshad/my-application.git (fetch)
origin https://github.com/mmumshad/my-application.git (push)
```

