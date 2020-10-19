# Ft_server
Setting up my first web server :)

# Introduction
This topic is intended to introduce you to system administration. 
It will make you aware of the importance of using scripts to automate your tasks.
For that, you will discover the "docker" technology and use it to install a complete web server with Nginx. 
This server will run multiples services: 
* Wordpress
* phpMyAdmin
* SQL database

# How to use it?

### Installing
```
git clone https://github.com/alineayumi/ft_server.git
```

### Content
* ```Dockerfile```
Contains the instructions to build the docker image for the server
* ```/srcs```
Contains all scripts and configuration files to support the container
* ```test.sh```
Builds the image and run the container
* ```clean.sh```
Remove and clean all running containers

### Building an image
```docker build -t ft_server .```

### Running a container from the ft_server image (autoindex on by default)
```docker run --name ft_server -it -p80:80 -p443:443 ft_server```

### Running a container with autoindex off
```docker run --env AUTOINDEX=off --name ft_server -it -p80:80 -p443:443 ft_server```

### Access to the container
```docker exec -it ft_server /bin/bash```
