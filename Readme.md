
Docker Pure-ftpd Server
============================

Pull down with docker:
```bash
sudo docker pull tomzo/pure-ftpd
```

----------------------------------------

Original work in `stilliard/pure-ftpd`.

This image has been modified to run on phusion baseimage, which has
fixed logging.

The `/ftp` directory is prepared to host anonymous user content.

Volume can be mounted with `--volume /host/path:/ftp`. Ownership of data
on host does not really matter because it is fixed at container
start using [this approach](https://github.com/tomzo/docker-uid-gid-fix)

----------------------------------------

Starting it
------------------------------

`docker run -d -p 21:21 --name ftpd_server --volume /host/path:/ftp tomzo/pure-ftpd `

Operating it
------------------------------

`docker exec -it ftpd_server /bin/bash`

Example usage once inside
------------------------------

Create an ftp user: `e.g. bob with chroot access only to /home/ftpusers/bob`
```bash
pure-pw useradd bob -u ftpuser -d /home/ftpusers/bob
pure-pw mkdb
```
*No restart should be needed.*

More info on usage here: https://download.pureftpd.org/pure-ftpd/doc/README.Virtual-Users


Test your connection
-------------------------
From the host machine:
```bash
ftp -p localhost 21
```

----------------------------------------

Default pure-ftpd options explained
-------------------------------------

```
/usr/sbin/pure-ftpd # path to pure-ftpd executable
-c 50 # --maxclientsnumber (no more than 50 people at once)
-C 10 # --maxclientsperip (no more than 10 requests from the same ip)
-l puredb:/etc/pure-ftpd/pureftpd.pdb # --login (login file for virtual users)
-E # --noanonymous (only real users)
-j # --createhomedir (auto create home directory if it doesnt already exist)
-R # --nochmod (prevent usage of the CHMOD command)
```

For more information please see `man pure-ftpd`, or visit: https://www.pureftpd.org/


Credits
-------------
Thanks for the help on stackoverflow with this!
https://stackoverflow.com/questions/23930167/installing-pure-ftpd-in-docker-debian-wheezy-error-421

And thanks stilliard for figuring out the compilation.
