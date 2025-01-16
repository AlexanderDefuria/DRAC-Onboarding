# Navigating the Environment
Navigating the terminal is an essential skill for using High Performance Computing (HPC) systems effectively. The terminal, also known as the command line interface (CLI) or shell, provides a text-based way to interact with the computer and execute commands. For HPC users, mastering basic terminal navigation is crucial for accessing remote systems, managing files, and running jobs.

## Basic Terminal Navigation

Below is a very basic introduction to navigating through the terminal environment. It is highly recommended that you become more familiar with navigating the environment through your own experience and external training. It is also highly recommended to become familiar with a terminal multiplexer of some kind like tmux or screen.

### Accessing the Terminal

To begin, you'll need to open a terminal:

- On Mac: Open the "Terminal" application from Applications > Utilities
- On Linux: Use the keyboard shortcut Ctrl+Alt+T or search for "Terminal" in your applications
- On Windows: Use PuTTY or Windows Subsystem for Linux (WSL) to access a Linux-like terminal

### Essential Commands

Here are some fundamental commands for navigating the terminal:

- **pwd**: Print Working Directory - shows your current location in the file system
- **ls**: List - displays the contents of the current directory
- **cd**: Change Directory - moves you to a different directory
- **mkdir**: Make Directory - creates a new folder
- **rm**: Remove - deletes files or directories
- **cp**: Copy - copies files or directories
- **mv**: Move - moves or renames files or directories

### Connecting to HPC Systems

To connect to an HPC system, you'll typically use SSH (Secure Shell):

```bash
ssh username@<system>.alliancecan.ca
```

Replace "username" with your account name and the address with the address of your HPC system of choice.

<note>
To access Alliance systems, you must have dual factor authentication setup and enabled. <a href="https://docs.alliancecan.ca/wiki/Multifactor_authentication">Find more information here.</a>
</note>
