# SSH

Syntax:

```bash
ssh <hostname OR IP address>

ssh <user>@<hostname OR IP address>

ssh -l <user> <hostname OR IP address>
```

e.g. remotely connect to machine with hostname devapp01 from Bob's machine (so we connect as bob when not specifying a user):

```bash
[bob@caleston-lp10 ~]$ ssh devapp01

bab@devapp01's password:
Last login: .....
[bob@devapp01 ~]$
```

![SSH](images/ssh.png)

## Password-less SSH

First create a key-pair on the client:

![Key pair](images/key-pair.png)

---

![SSH keygen](images/ssh-keygen.png)

Now we have to copy the public key to the remote server:

![SSH copy ID](images/ssh-copy-id.png)

## SCP

![SCP](images/scp.png)

To copy a directory instead of just a file, use the **-r** option and use **-p** to maintain the permissions e.g.

![SCP directory](images/scp-directory.png)