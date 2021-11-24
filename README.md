# docker-kinetic
```
git clone https://github.com/Sridhar701Pitt/docker-kinetic kinetic_catkin_ws
```
## Pre-Requisites - Not comprehensive
-> Please refer to the comments in the docker file to setup the nvidia drivers for docker

-> Add this to etc/profile to enable docker access to xhost display

```
if [ "$DISPLAY" != "" ]
then
  xhost +local:docker
fi
```
Else you have to run the following command in every terminal you run the docker container
```
xhost +local:docker
```
## Setup
### Docker build command
Builds the docker container with name ros:mykinetic - run this in the same directory as the dockerfile.

You can add packages to the dockerfile to install dependencies before building it.

You have to build the container everytime you change the dockerfile
```
docker build -t ros:mykinetic .
```
### .env file update
Update the ROS Master and host params in the .env file with the current ip values.

### Execute this command in the kinetic_catkin_ws (along with the .env file) to start the container
You can use the tmux utility package to get multiple terminals inside the current terminal (included as part of the docker file).

Else, you can do ```docker exec -it ....``` command from another terminal to access the running container
```
docker run -it --rm --privileged --net=host --env-file ./.env -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v "$(pwd)":/root/kinetic_catkin_ws --gpus all ros:mykinetic /bin/bash
```

### Exiting from the container
Do ```exit``` in terminal to exit and close the running container
## Setting envs
```ENV TURTLEBOT3_MODEL=burger```

```RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc```
### Other useful commands
Shows running containers on host

```docker ps```

Shows all built docker images on host

```docker images```