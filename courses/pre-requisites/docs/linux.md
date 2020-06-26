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

## User Accounts

- **sudo** - /etc/sudoers which allows a user to have (temporary) access as **root** i.e. able to do anything e.g. **sudo ls /root**
- **su someuser** - switch user, where you will be prompted for the user's password
- **ssh someuser@192.168.1.2** - to ssh onto some remote box as specified user

```bash
devops-backwards at ☸️ docker-desktop
➜ whoami
davidainslie

➜ id
uid=501(davidainslie) gid=20(staff) groups=20(staff),12(everyone),61(localaccounts),79(_appserverusr),80(admin),81(_appserveradm),98(_lpadmin),701(com.apple.sharepoint.group.1),33(_appstore),100(_lpoperator),204(_developer),250(_analyticsusers),395(com.apple.access_ftp),398(com.apple.access_screensharing),399(com.apple.access_ssh),400(com.apple.access_remote_ae)
```

## Download Files

```
devops-backwards at ☸️ docker-desktop
➜ curl http://www.some-site.com/some-file.txt -O
some-file.txt
```

The **-O** option will save the file downloaded by **curl**, otherwise (without it) the contents of the file are simply shown on screen.

```bash
devops-backwards at ☸️ docker-desktop
➜ wget http://www.some-site.com/some-file.txt -O some-file.txt
some-file.txt
```

## OS Version

```bash
devops-backwards at ☸️ docker-desktop
➜ ls /etc/*release*
/etc/centos-release
/etc/os-release

➜ cat /etc/*release*
Centos Linux release 7.7.1908 (Core)
...
```

The above is for (real) Linux. For a Mac:

```bash
devops-backwards on  master [!] at ☸️ docker-desktop
➜ sw_vers -productVersion
10.15.5
```

## Package Management

- RPM - Red Hat Package Manager

Install package:

```bash
rpm -i telnet.rpm
```

Uninstall package:

```bash
rpm -e telnet.rpm
```

Query package:

```bash
rpm -q telnet
```

To can get exact package name:

```bash
rpm -qa | grep ftp
```



However, what if a rpm depends on some other rpm? Problem e.g. installing **ansible** would need **python** and more, so we would have to install the python rpm. **YUM** can install a package and also all dependencies.

- YUM - under the hood uses rpm but adds the feature of getting dependencies

```bash
yum install ansible
```

YUM's repository configuration is at: **/etc/yum.repos.d**:

```bash
yum repolist
```

```bash
yum list ansible
```

```bash
yum remove ansible
```

```bash
yum --showduplicates list ansible
```

```bash
yum install ansible-2.4.2.0
```

## Services

Start **httpd** service:

```bash
service httpd start
```

Or the newer (better) way is:

```bash
systemctl start httpd
```

and other commands:

```bash
systemctl stop httpd

systemctl status httpd
```

and to configure http to start at startup (server boot):

```bash
systemctl enable httpd
```

Configure http to not start at startup:

```bash
systemctl disable httpd
```

So, wouldn't it be nice if we could do:

```bash
systemctl start my_app

systemctl stop my_app
```

instead of:

```bash
/usr/bin/python3 /opt/code/my_app.py
* Serving Flask app "my_app"
...

curl http://localhost:5000
Hello, World
```

We must configure our program as a **systemd** service. We need a systemd file under **/etc/systemd/system** or **/usr/lib/systemd/system**. We would create a file (named as the service we wish to use with systemctl) e.g. **my_app.service**:

```bash
[Unit]
Description=My python web application

[Service]
ExecStart=/user/bin/python3 /opt/code/my_app.py
ExecStartPre=/opt/code/configure_db.sh # Specifying anything you need to run before booting this service
ExecStartPost=/opt/code/email_status.sh # Run something after service booted
Restart=always

[Install]
WantedBy=multi-user.target # This lets you use "system enable my_app"
```

To let **systemd** know there is a new service configured, run:

```bash
systemctl daemon-reload
```

then

```bash
systemctl start my_app
```

As an example, **Docker** is configured as a service in **/lib/systemd/system/docker.service**:

```bash
[Unit]
Description=Docker Application Container Engine
...

[Service]
...
```





## 

