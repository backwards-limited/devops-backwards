# Networking

## DNS

Two computers on the same network can access each other via their IPs, but initially not by some hostname representing an IP:

![DNS connect](images/dns-connect.png)

So update **/etc/hosts**:

![Etc hosts](images/etc-hosts.png)

The hostname on **A** is only relevant to **A** e.g. performing a **hostname** command on **B** would reveal a different hostname e.g.

```bash
[B]> hostname
host-2
```

We can even fool **A** into thinking that **B** is google e.g.

![Google cheat](images/google.png)

And it is the same for other commands which will also use the **/etc/hosts** file e.g.

```bash
[A]> ping db

[A]> ssh db

[A]> curl http://www.google.com
```

The above is known as **name resolution** and is fine for a limited number of computers on the same network (but won't scale):

![Name resolution](images/name-resolution.png)

The other (better) approach, is to move all these entries (from /etc/hosts) to one central server that we call the **DNS server**, pointing all hosts to the DNS server to resolve a hostname (to an IP):

![DNS server](images/dns-server.png)

So now we must configure each host to point to said DNS server, which is done in **/etc/resolv.conf**, but you can still use your **/etc/hosts** for specific name resolution such as some test server that only a few are using:

![Resolv](images/resolv.png)

In fact name resolution is done by:

- first check **/etc/hosts** and if the name is not resolved then
- check **/etc/resolv.conf** which checks the host configuration on the **nameserver** i.e the **DNS server**

so you can have duplicate name entries where /etc/hosts takes precedence, where the order is defines in **/etc/nsswitch.conf**:

```bash
$ cat /etc/nsswitch.conf

hosts: files dns
```

There is also a public DNS server managed by Google e.g. facebook is not configured in our DNS server or local /etc/hosts so the public DNS server can also be used for name resolution:

![Facebook](images/facebook.png)

But it would be better to even move that second (public) nameserver onto our network's DNS server once again avoiding configuring every computer on our network to include the public DNS server:

![Public DNS](images/public-dns.png)

But how does this **www** and **.com** actually work?

![Domain names](images/domain-names.png)

---

![Domain name hierarchy](images/domain-name-hierarchy.png)

Going through this hierarchy is via assinged DNS servers essentially at each level and once the IP is acquired your network's DNS server will probably cache it for a short period of time:

![Hierarchy lookup](images/hierarchy-lookup.png)

And your company's DNS server is probably set up the same way:

![Your org DNS server](images/your-org-dns-server.png)

To be able to access say **web** which will now be configured according to the domain name hierarchy rules such as **web.mycompany.com** we need an extra entry in **/etc/resolv.conf** as **search** to append **mycompany.com** to **web** meaning we can resolve both **web** and **web.mycompany.com**:

![Search domain](images/search-domain.png)

Finally, there are also **record types** for mapping:

![Record types](images/record-types.png)