# Commands

## Run

Start a container i.e. instantiate a container from an image e.g.

```bash
➜ docker container run docker/whalesay cowsay Well Howdy do
Unable to find image 'docker/whalesay:latest' locally
latest: Pulling from docker/whalesay
...
```

Note that running a container may simply exit (where **docker container ls -a** would show an exited container).

E.g. **docker run ubuntu** would just exit. But why? Containers are not designed to just run an operating system, they are designed to run a server such as a web application - it is the running of a service that we would want the container to keep running, and once said service (task) is complete, then shutdown the container. A container exists as long as the process inside it is alive.

The following would at least keep the container running for 5 seconds, but after that the container exits:

```bash
➜ docker container run ubuntu sleep 5
```

## List

List containers with **ps** e.g.

```bash
➜ docker container ls -a
CONTAINER ID    IMAGE             COMMAND                  STATUS                        PORTS         NAMES
f43a8a726b72    docker/whalesay   "cowsay Well Howdy do"   Exited (0) About a minute ago       relaxed_bassi
```

## Stop

```bash
➜ docker container stop relaxed_bassi
```

## Remove

Remove a (stopped) container e.g.

```bash
➜ docker container rm relaxed_bassi
```

## List Images

```bash
➜ docker image ls
REPOSITORY                 TAG                                             IMAGE ID      CREATED        SIZE
docker/desktop-kubernetes  kubernetes-v1.19.3-cni-v0.8.5-critools-v1.17.0  7f85afe431d8  6 weeks ago    285MB
zookeeper                  latest                                          36b7f3aa2340  2 months ago   252MB
confluentinc/cp-kafka      latest                                          44013623fec8  2 months ago   721MB
```

## Remove Image

```bash
➜ docker image rmi bretfisher/netshoot
Untagged: bretfisher/netshoot:latest
Untagged: bretfisher/netshoot@sha256:f59fe68adf8d4097832189626e7ca911f16ccb3b592050d06cc747c3feffd8b3
Deleted: sha256:718697f4314736dc2cc93c510bd53707097f46273417853806887576ff6b7ad4
Deleted: sha256:a6ba0a201e209d0b842941da4fe5180c75aa40e0376022e6932c6b53d9a5e446
Deleted: sha256:66a81506e944e9e179eec532a3f0b732d2a7bff61fb31d40dda43e6b08479f20
Deleted: sha256:91e90346217d7ad84aba2c7eb4752f75b2a42c119c2a52c62d5caaad04a52b29
Deleted: sha256:45480659cb3e8bc80d392500561749481e0518f28233da1a8319a07a9a0c96c7
Deleted: sha256:c438baaf4a1dfa02867d3274fc7990f6592405ca00c25570a08e82af876cc3ee
Deleted: sha256:b7c24b863ad42adf3916c21b78983151486cc4a397bca79428925cfb8efaa257
```

## Pull Image

Only pull an image to your machine and not run it (where run would pull and then run) e.g.

```bash
➜ docker image pull nginx
Using default tag: latest
latest: Pulling from library/nginx
...
```

## Execute Command (on running container)

Use the **exec** command e.g.

```bash
➜ docker container run -d ubuntu sleep 200
46266cfe0b2903c866bf807afabff0b69fbdb7fee98c923c4c4f8bbc4de16fc7
```

We would now like to view the contents of a file inside the container:

```bash
➜ docker container exec condescending_kowalevski cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	46266cfe0b29
```

## Attach

Running a container **detached** is useful, but maybe we want to easily view the output (logs) again:

```bash
➜ docker container run -d kodekloud/simple-webapp
Unable to find image 'kodekloud/simple-webapp:latest' locally
latest: Pulling from kodekloud/simple-webapp
```

```bash
➜ docker container ls
CONTAINER ID    IMAGE                     COMMAND           STATUS          PORTS    NAMES
a0d2069956aa    kodekloud/simple-webapp   "python app.py"   Up 29 seconds   8080     compassionate_sutherland
```

```
➜ docker container attach a0d2
```

