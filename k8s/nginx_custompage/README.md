# K8S -- nginx_custompage

Feel free to run the container on its own by doing:

```
docker build -t nginx_custompage .
```

Once done, nginx in container can be opened by inputting this command:

```
docker run -it -p 80:80 nginx_custompage
```

After that, nginx welcome page is expected to be visible on 127.0.0.1:80 
