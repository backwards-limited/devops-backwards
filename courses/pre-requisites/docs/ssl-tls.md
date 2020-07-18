# SSL & TLS

## Without SSL

![Without SSL](images/without-ssl.png)

## Symmetric Encryption

We could use **symmetric encryption** where a **key** is used to encrypt the data to send. However, the key is sent along with the data so that the receiving server can decrypt the data, and so a hacker can also grab that key to decrypt (which kind of defeats the purpose).

So a **key** is used encrypt data;

![Encrypt](images/symmetric-key.png)

---

![Encrypt 2](images/symmetric-key-encrypt.png)

---

![Decrypt](images/symmetric-decrypt.png)

and whoops... the hacker still gets the data:

![Decrypt](images/symmetric-decrypt-2.png)

So the **problem** with **symmetric encryption** is that there is only **one key** - the same key is used to encrypt / decrypt and said key is passed along with the data.

## Asymmetric Encryption

Here we have two keys - a **private** and **public** key. In the following explanation, we'll call the **public key** as **public lock** so:

![Public key](images/public-key.png)

---

![Public lock](images/public-lock.png)

The idea is that we encrypt (lock) data with the **public lock** and can then only decrypt (unlock) with the associated **private key**:

![Lock](images/asymmetric-lock.png)

---

![Unlock](images/asymmetric-unlock.png)

We can use **key pairs** for **ssh** instead of user / password - so we need to generate a public and private key pair - The steps are:

Use **ssh-keygen** to generate a private and public key pair:

![SSH key pair](images/ssh-keypair.png)

With the **public key** (copied) on the server, when you ssh to the server, you specify the location of your **private key**:

![SSH login](images/ssh-login.png)

And you can copy your **public key** onto multiple servers and still use the same **private key**. Of course there will be multiple users, so each public key has too be entered into **~/.ssh/authorized_keys**:

![SSH multiple users](images/ssh-multiple-users.png)

Ok. Back to the client / server example using asymmetric encryption.

On the server, use **openssl** to generate a **private** and **public** key pair - First the **private key**:

![OpenSSL private key gen](images/openssl-private-key-gen.png)

---

![OpenSSL private key](images/openssl-private-key.png)

then the **public key**:

![OpenSSL public key gen](images/openssl-public-key-gen.png)

---

![OpenSSL public key](images/images/openssl-public-key)