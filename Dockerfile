### https://dev.to/et813/install-docker-and-nvidia-container-m0j
## According to the site,
## Make sure you have installed the NVIDIA driver and Docker 19.03 for your Linux distribution Note that you do not need to install the CUDA toolkit on the host, but the driver needs to be installed.
## ^^ See this for running GUIs

## https://www.emse.fr/~boissier/enseignement/defiia/up9/ros-docker-tp.html
## https://github.com/ros-visualization/rviz/issues/1170#issuecomment-632188358
FROM nvidia/cudagl:9.0-base-ubuntu16.04

ENV UBUNTU_RELEASE=xenial
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $UBUNTU_RELEASE main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update

RUN apt-get install -y curl
ARG DEBIAN_FRONTEND=noninteractive

# INSTALL OTHER NECESSARY PACKAGES
RUN apt-get install -y tmux
RUN apt-get install -y git
RUN apt-get install -y wget
RUN apt-get update
RUN apt-get install -y python-pip

#install net-tools
RUN apt-get install -y net-tools
RUN apt-get install -y nano

# RUN apt-get install -y libarmadillo-dev
# RUN pip install Mosek
#Copy mosek license file
# COPY ./mosek.lic /root/mosek/mosek.lic

#Ros dependenciey stuff
RUN apt-get update

# https://unix.stackexchange.com/a/642418
RUN apt-get install -y mesa-utils
#Set some bashrc stuff
RUN echo 'alias scat="source devel/setup.bash"' >> ~/.bash_aliases
RUN echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc

#ROS dependencies
RUN apt-get install -y python-rosdep  python-wstool  build-essential python-rosinstall-generator python-rosinstall
RUN apt-get update
RUN apt-get install -y python-catkin-tools
RUN rosdep init && rosdep update --rosdistro=kinetic

#more packages
RUN apt-get install -y psmisc

#Set Work dir
WORKDIR /root/kinetic_catkin_ws

CMD ["tail", "-f", "/dev/null"]