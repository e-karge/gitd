gitd
====

Minimal docker image providing git as a service (via ssh).


Usage
-----

### Running the container

```
docker run -d -p 2222:22 ekarge/gitd
```

The default password for accessing the repositories is `git`.
This can be changed by running the container with like this:

```
docker run -d -p 2222:22 -e "PASSWD=<your-password>" ekarge/gitd
```

Alternatively you can pass a initial public key:

```
docker run -d -p 2222:22 -e "PUBKEY=<your-public-key>" ekarge/gitd
```

Password authentication is disabled in this case. To allow for public key authentication and password authentication
you have to specify a password as well:

```
docker run -d -p 2222:22 -e "PUBKEY=<your-public-key>" -e "PASSWD=<your-password>"ekarge/gitd
```


### Uploading your public ssh key (optional)

```
ssh-copy-id git@<your-dockerhost> -p 2222
```


### Creating a new repository

```
ssh git@<your-docker-host> -p 2222 -- git init --bare <reponame>.git
```


### Cloning a repository

```
git clone ssh://git@<your-docker-host>:2222/~/<reponame>
```
