# Copying Files


Transferring files to and from Alliance clusters should be done through **data transfer nodes** (data movers) rather than login nodes for better performance and to avoid overloading login resources. If you need a secure and efficient way to move files from your personal computer, you can use command-line tools such as [SCP](https://man7.org/linux/man-pages/man1/scp.1.html), [SFTP](https://man7.org/linux/man-pages/man1/sftp.1.html), or higher-level programs like [WinSCP](https://winscp.net/eng/docs/start) and [MobaXterm](https://mobaxterm.mobatek.net/) on Windows.

| Service | Ease of Use | Practicality |
|---------|-------------|--------------|
| SCP     | 2           | 3            |
| rsync   | 2           | 3            |
| Globus  | 3           | 2            |
| SFTP    | 1           | 1            |



When transferring data between **different clusters**, **Globus** is the recommended tool due to its speed and reliability. It automatically uses data transfer nodes and can also be configured to **sync** files instead of overwriting them, ensuring only new or changed files get transferred. Refer to the [Globus documentation](https://docs.globus.org/) for setup details.

To **synchronize directories or large datasets**, consider using [rsync](https://download.samba.org/pub/rsync/rsync.html). By default, it compares file modification time and size, only sending differences. For large or numerous files, use options like `--partial` and `--progress` to resume interrupted transfers and see progress bars. Avoid preserving group ownership (i.e., don’t use `-p`/`-g`) when sending files to `/project` directories to prevent *Disk quota exceeded* errors.

For **downloads from the web**, tools like [wget](https://www.gnu.org/software/wget/manual/) and [curl](https://curl.se/docs/manpage.html) can resume interrupted transfers using their respective command-line flags. If you need to move data from cloud services, [rclone](https://rclone.org/docs/) is a good alternative, supporting services such as Google Drive and Google Photos.

If you want to **verify files** after transferring or if syncing tools are insufficient, you can generate checksums with commands like [sha1sum](https://man7.org/linux/man-pages/man1/sha1sum.1.html). Comparing checksums on the source and destination ensures file integrity across different systems.

For full details, including additional transfer examples, consult the [Alliance Transferring Data Guide](https://docs.alliancecan.ca/wiki/Transferring_data).


When transferring data, it's important to use **data transfer nodes** (also called data mover nodes) instead of login nodes. These nodes are specifically designed for efficient data transfer and are available for most Alliance clusters.

For transferring data between your personal computer and Alliance systems, several options are available:

1. Command-line tools: [scp](https://linux.die.net/man/1/scp) and [sftp](https://linux.die.net/man/1/sftp) for Linux and Mac users.
2. Graphical tools: [MobaXterm](https://mobaxterm.mobatek.net/) and [WinSCP](https://winscp.net/eng/index.php) for Windows users.
3. [Globus Personal Connect](https://www.globus.org/globus-connect-personal): Recommended for transfers taking more than a minute.

For transfers between Alliance resources, [Globus](https://docs.globus.org/) is the preferred tool. However, other methods like scp can also be used.

To download data from websites, [wget](https://www.gnu.org/software/wget/) and [curl](https://curl.se/) are standard tools available on Alliance clusters. For cloud services like Google Drive, consider using [rclone](https://rclone.org/).

Synchronizing files between two locations can be done using several methods:

1. [Globus](https://docs.globus.org/): Offers the best performance and reliability.
2. [rsync](https://linux.die.net/man/1/rsync): A popular tool for ensuring two datasets are the same.
3. Checksums: Useful for verifying file integrity when other methods are unavailable.

For secure file transfers, [SFTP](https://linux.die.net/man/1/sftp) and [SCP](https://linux.die.net/man/1/scp) are reliable options. Both use the SSH protocol to encrypt data during transfer.

Remember to always initiate transfers from your local computer when using SCP, regardless of the transfer direction. Also, be cautious when using `scp -r` to transfer data into `/project` directories, as it may lead to quota-related issues[1][2].

Citations:
[1] https://docs.alliancecan.ca/wiki/Transferring_data
[2] https://docs.alliancecan.ca/wiki/Transferring_data