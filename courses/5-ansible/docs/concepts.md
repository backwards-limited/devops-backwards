# Ansible Concepts

## Inventory

![Agentless](images/agentless.png)

An **inventory** takes on an **ini** format. Example:

![Inventory example](images/inventory-example.png)

Note that Linux and Windows machine have slight different parameters e.g.

```ini
# Web Servers
web1 ansible_host=svr1.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=svr2.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web3 ansible_host=svr3.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!

# Database Servers
db1 ansible_host=svr4.com ansible_connection=winrm ansible_user=administrator ansible_password=Password123!

[web_servers]
web1
web2
web3

[db_servers]
db1

[all_servers:children]
web_servers
db_servers
```

