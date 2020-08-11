# Databases

![SQL vs NoSql](images/sql-vs-nosql.png)

```sql
select * from persons where age > 10
```

```json
db.persons.find({ age: { $gt: 10 } })
```

## MySql

Example installation on Linux:

![Install MySql](images/install-mysql.png)

---

![Temp password](images/temp-password.png)

If you missed the **temporary password** then:

```bash
sudo grep 'temporary password' /var/log/mysqld.log
2020-07-17T21:17:19.768885Z 1 [Note] A temporary password is generated for root@localhost: _<dwFunVV1ka
```

![MySql login](images/mysql-login.png)

And then change the **root** password as shown in the following screenshot or:

```bash
mysql -u root -p
(enter password what you got from sudo grep 'temporary password' /var/log/mysqld.log command earlier)
```

and then:

```mysql
mysql> set password = password('P@ssw0rd123');

mysql> flush privileges;
```

![MySql validate](images/mysql-validate.png)

---

![MySql basics](images/mysql-basics.png)

---

![MySql create user](images/mysql-create-user.png)

---

![MySql create user remote](images/mysql-create-user-remote.png)

To be able to access MySql from any box:

```bash
mysql> create user 'john'@'%' identified by 'MyNewPass4!';
```

![MySql privileges](images/mysql-privileges.png)

## MongoDB

![MongoDB](images/mongodb.png)

---

![Mongo shell](images/mongo-shell.png)

---

![Mongo find](images/mongo-find.png)

