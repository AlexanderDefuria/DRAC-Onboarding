# Basic Linux Terminal Navigation

This guide covers the basic commands for navigating the Linux terminal.

## Table of Contents
1. [Introduction](#introduction)
2. [Basic Commands](#basic-commands)
    - [pwd](#pwd)
    - [ls](#ls)
    - [cd](#cd)
3. [Conclusion](#conclusion)

## Introduction
Navigating the Linux terminal is an essential skill for any developer or system administrator. This guide will introduce you to the basic commands needed to move around the file system.

## Basic Commands

### `pwd`
The `pwd` (print working directory) command displays the current directory you are in.

```sh
pwd
```

### `ls`
The `ls` (list) command lists the files and directories in the current directory.

```sh
ls
```

Options:
- `ls -l`: Lists files in long format.
- `ls -a`: Lists all files, including hidden files.

### `cd`
The `cd` (change directory) command is used to change the current directory.

```sh
cd /path/to/directory
```

Examples:
- `cd ..`: Move up one directory level.
- `cd ~`: Move to the home directory.

### `cat`
The `cat` command is used to display the contents of a file.

```sh
cat filename
```

### `nano`
The `nano` command is a simple text editor that allows you to create and edit files from the terminal.

```sh
nano filename
```

- To create a new file, simply provide a new filename that does not exist.
- To save and exit the editor, press `Ctrl + X`, then `Y` to confirm, and `Enter` to exit.
- To exit without saving, press `Ctrl + X`, then `N` to discard changes, and `Enter` to exit.




## Conclusion
These basic commands will help you get started with navigating the Linux terminal. Practice using them to become more comfortable with the command line interface.