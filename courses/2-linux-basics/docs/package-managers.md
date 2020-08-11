# Package Managers

![Package managers](images/package-managers.png)

## RPM and YUM

![RPM](images/rpm.png)

---

![Working with RPM](images/working-with-rpm.png)

**Note** that **RPM** does not resolve **dependencies** and so you would normally use something at a higher level that does such as **YUM**:

![YUM](images/yum.png)

```bash
yum install firefox -y

yum repolist

yum provides tcpdump
```

## DPKG and APT

![DPKG](images/dpkg.png)

Similar to RPM, **DPKG** does not resolve dependencies. Use **APT / APT-GET** which is the Debian equivalent to YUM.

![APT](images/apt.png)

---

![APT](images/apt-more.png)

