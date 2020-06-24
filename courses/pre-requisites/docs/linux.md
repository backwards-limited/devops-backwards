# Linux

## Introduction

```bash
workspace/backwards/devops-backwards at ☸️ docker-desktop
➜ echo $SHELL
/bin/zsh
```

Create **directory tree**:

```bash
workspace/backwards/devops-backwards at ☸️ docker-desktop
➜ mkdir -p /tmp/asia/india/bangalore
```

Recursively copy (new) directory:

```bash
workspace/backwards/devops-backwards at ☸️ docker-desktop
➜ cp -r /tmp/asia /tmp/asia-new
```

Create a new file and then add contents:

```bash
workspace/backwards/devops-backwards at ☸️ docker-desktop
➜ touch mytemp

➜ cat > mytemp
hi
there
<Ctl-D>
```

## VI Editor

- Command mode (default - such as upon opening a file)
  - **x** - delete character
  - **dd** - delete line
  - **u** - undo
  - **:s/foo/bar** - replace first occurrence of **foo** on current line with **bar**
  - **:s/foo/bar/g** - replace all **foo** on current line with **bar**
  - **:%s/foo/bar/g** - replace all **foo** with **bar**
  - **yy** - copy line
  - **p** - paste
  - **Ctl + u** - scroll up
  - **Ctl + d** - scroll down
  - **:** - takes you to **prompt** to type in commands
    - **:w filename** - save file to specified file
    - **/of** - find the word **of** and press **n** key to go to each occurrence
- Insert mode

## 

