# GCP Source Repository (git) howto


1. enable Source Repository API in google cloud console in corresponding [project name]

2. create new repository name in google cloud console 
  2.1. register local public key in ~/.ssh/id_rsa.pub in case of SSH authentication

3. using google git repository

```
$ git init

$ git remote add google ssh://[id]@gmail.com@source.developers.google.com:2022/p/[project name]/r/[repository name]

$ git push --all google

$ git remote -v

$ git add *
$ git commit -m "init"

$ git push --all google
```

