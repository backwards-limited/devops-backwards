# Tier Applications

Goal:

![Tier application](images/tier-application.png)

We do the following:

![Tier application steps](images/tier-application-steps.png)

---

![Tier application steps](images/tier-application-steps-2.png)

And what if we wanted to distribute the above deployment i.e. not deploy everything onto the same box, but say, have the database on  one machine, and the rest on another? The PHP application would have to be configured to the correct IP of the database, and the database user added, would need the IP of the server that is accessing said database:

![Tier application distributed](images/tier-application-distributed.png)