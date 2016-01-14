gitd
====

Minimal docker image providing git as a service (via ssh).


Usage
-----

### Run container as deamon

```
docker run -d -p 2222:22 ekarge/gitd
```

Replace `2222` with whichever port you want to listen at.


### Upload your public ssh key (optional)

```
ssh-copy-id git@<your-dockerhost> -p 2222
```


### Create a new repository via

```
ssh git@<your-docker-host> -p 2222 -- git init --bare <reponame>.git
```


### Clone a repository

```
git clone ssh://git@<your-docker-host>:2222/~/<reponame>
```
