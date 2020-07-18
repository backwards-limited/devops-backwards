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

#### SSH

We can use **key pairs** for **ssh** instead of user / password - so we need to generate a public and private key pair - The steps are:

Use **ssh-keygen** to generate a private and public key pair:

![SSH key pair](images/ssh-keypair.png)

With the **public key** (copied) on the server, when you ssh to the server, you specify the location of your **private key**:

![SSH login](images/ssh-login.png)

And you can copy your **public key** onto multiple servers and still use the same **private key**. Of course there will be multiple users, so each public key has too be entered into **~/.ssh/authorized_keys**:

![SSH multiple users](images/ssh-multiple-users.png)

#### Client / Server

Ok. Back to the client / server example using asymmetric encryption.

On the server, use **openssl** to generate a **private** and **public** key pair - First the **private key**:

![OpenSSL private key gen](images/openssl-private-key-gen.png)

---

![OpenSSL private key](images/openssl-private-key.png)

then the **public key**:

![OpenSSL public key gen](images/openssl-public-key-gen.png)

---

![OpenSSL public key](images/openssl-public-key-show.png)

When the user first uses **https**, he gets the **public key** from the **server**.

Assume a hacker also gets the public key:

![Both get public key](images/both-get-public-key.png)

The user (well actually the user's **browser**) encrypts the **symmetric key** with the **public key** provided by the server. The symmetric key is now secure:

![Encrypt symmentric key](images/encrypt-symmetric-key.png)

The secure (encrypted) symmetric key is sent to the server (before we simply sent the symmetric key) - Again the hacker also gets a copy:

![Send encrypted symmetric key](images/send-encrypted-symmetric-key.png)

The server now uses the **private key** to decrypt (unlock) and gain access to the symmetric key - As the hacker does not have the private key, it can't decrypt to get at the symmetric key, and without said key, the hacker will not be able to decrypt data:

![Decrypt symmetric key](images/decrypt-symmtric-key.png)

**Asymmetric key encryption essentially makes the symmetric key useless to any hackers**.

Now, whenever a user encrypts data (to send) using the symmetric key, only the server (who now also has access to the symmetric key) can decrypt the data. **Yee ha**!

![Encrypt data](images/encrypt-data.png)

---

![Encrypt data](images/encrypt-data-2.png)

---

![Encrypt data](images/encrypt-data-3.png)

---

![Encrypt data](images/encrypt-data-4.png)

**With asymmetric encryption, we have successfully transferred the symmetric key from user to server**.

So what does the hacker do? Fakes the server website.

## Fake Server Website

The hacker creates a **duplicate** of the server (on his own server) and can then generate fake asymmetric key pair:

![Fake website](images/fake-website.png)

He then has to tweak / route your traffic to the fake website:

![Fake website](images/fake-website-2.png)

The hacker now needs to capture your credentials (user login and password). Upon going to the fake website, you now receive the fake public key which you'll use to encrypt your symmetric key:

![Fake website](images/fake-website-3.png)

Hacker now decrypts to finally get access to your symmetric key:

![Fake website](images/fake-website-4.png)

Whoops! You will now encrypt your credentials with your symmetric key that the hacker now has:

![Fake website](images/fake-website-5.png)

---

![Fake website](images/encrypt-data-6.png)

---

![Fake website](images/encrypt-data-7.png)

---

![Fake website](images/encrypt-data-8.png)

You have been communicating securely, **but with the wrong (fake) website**.

![Fake website](images/encrypt-data-9.png)

**What if you could look at the incoming public key and assert that it is legitimate?**

![Verify asymmetric public key](images/verify-key.png)

This time a **certificate** must be sent by the server, and this certificate will contain the asymmetric public key (so now the user receives a certificate along with the public key, and not just the public key alone). The user can examine this certificate. It is like a real certificate but in digital format (on the right showing the actual output of a certificate):

![Certificate](images/certificate.png)

The most important part of the certificate is **who signed and issued the certificate**?

![Signed certificate](images/certificate-signed.png)

A **self signed** certificate is not safe because the person issuing it did the signing e.g. a hacker signs his own certificate. The browser detects a self signed certificate for you:

![Not safe](images/not-safe.png)

How is a legitimate certificate generated that your web browser with trust? How to get your certificate signed by someone with authority? That is when we need a **Certificate Authority (CA)** - some are:

![Certificate authorities](images/certificate-authorities.png)

The steps are:

Generate a **Certificate Signing Request (CSR)** using the key we generated earlier i.e. the asymmetric public key:

![CSR](images/csr.png)

where the CSR looks like:

![CSR Details](images/csr-details.png)

The CA will **validate information** and then **sign and send the certificate** back to you:

![Signed certificate](images/signed-certificate.png)

Now you have a certificate that the browser trusts:

![Browser trusts](images/browser-trusts.png)

But how does the browser actually know that the CA is legitimate? E.g. what if the certificate was signed by a fake CA?

Once again, all CAs have their own asymmetric key pairs (the CA uses their private key to sign the certificates):

![CA key pair](images/ca-key-pair.png)

where their public keys are built into the browser:

![CA key pair](images/ca-key-pair-2.png)

The browser then uses the public keys to check whether the certificates were indeed signed by the CA themselves (and not a fake one). See under **settings** of your web browser:

![Web browser CA settings](images/web-browser-ca-settings.png)

All the above is fine regarding **public sites**, but what about sites hosted privately within your organisation? Well, you can host your own private instance of a CA, and most CAs offer this service - you would then have your organisation's own asymmetric public keys also stored within all employee web browsers.

Finally, **what can the server do, to check on who the client says they are**? The server doesn't want to end up talking to a hacker.

Well, the server could demand, upon initial interaction, a certificate from the client which is also signed by a CA i.e. a client would have to generate a CSR, send it to a CA and so provide a validated signed certificate to the server, which it can check against the CA.

All of the above around certificates, signing, CAs etc, is known as **Public Key Infrastructure (PKI)**.

A note on naming conventions:

A certificate with a public key usually end with ***.crt** or ***.pem** e.g.

![Certificate with public key naming](images/certificate-public-key-naming.png)

The private key will usually end with ***.key** or ***-key.pem** e.g.

![Private key naming](images/private-key-naming.png)