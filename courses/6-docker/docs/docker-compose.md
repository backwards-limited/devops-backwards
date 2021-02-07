# Docker Compose

Take a look at an application stack - voting application:

![Voting application](images/voting-application.jpg)

Without Docker Compose we could do something like:

![Voting application docker run](images/voting-application-docker-run.jpg)

Alas, it does not work. When we access the web interface of the `voting-app` we see:

![Interface error](images/interface-error.jpg)

We have successfully started all the services, but we've not actually linked them together.
We should have used the option `--links` to link containers.

e.g. the voting-application has the following code:

![Voting application code](images/voting-application-code.jpg)

so we would need:

```bash
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
```

Essentially this link creates an entry in the `/etc/hosts` file in the voting-application Docker container:

![Etc hosts](images/etchosts.jpg)

The equivalent using Docker Compose is much easier:

![Docker compose](images/docker-compose.jpg)

For our own application we can have the image built:

![Docker compose build](images/docker-compose-build.jpg)

Docker Compose versions have advanced:

![Docker compose versions](images/docker-compose-versions.jpg)

**What about networks?** We would like the UI apps to be on a `front-end network` and the rest on a `back-end network`.

For example:

![Docker compose networks](images/docker-compose-networks.jpg)