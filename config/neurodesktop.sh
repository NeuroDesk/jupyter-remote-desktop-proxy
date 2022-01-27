#!/bin/bash

cvmfs2 -o config=/cvmfs/neurodesk.conf neurodesk.ardc.edu.au /cvmfs/neurodesk.ardc.edu.au

USER=jovyan vncserver -kill :1
USER=jovyan vncserver -depth 24 -geometry 1920x1080 -name \"VNC\" :1
/home/jovyan/.tomcat/bin/startup.sh
guacd -f -L debug
echo "==========================================================="