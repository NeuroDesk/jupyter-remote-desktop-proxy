# jupyter-remote-desktop-proxy

Open in
http://168.138.100.96/v2/gh/NeuroDesk/jupyter-remote-desktop-proxy/demo?urlpath=neurodesktop

Start New > neurodesktop

Wait for 10-15 seconds.

If the page times out or produces 505 error, refresh.

Guacamole:

- username: jovyan
- password: password


## For Developers
For local testing use `build_and_run.sh`

For updating the binderhub image:
1. `bash build_and_push.sh`. This will push the new image to vnmd and update binder/Dockerfile
2. Commit and push `binder/Dockerfile` so mybinder will use the new image.
