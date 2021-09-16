docker build -t neurodesktop_jupyter . --file Dockerfile.focal_base && (
    echo "Starting:"
    @REM sudo docker run -d --privileged --name vnm -v /vnm:/vnm -e RESOLUTION=1600x960 -e USER=neuro -p 6080:80 -p 5900:5900 vnm:latest
    @REM docker run -d --name neurodesktop_jupyter -p 8888:8888 neurodesktop_jupyter
    docker run -it --name neurodesktop_jupyter -p 8888:8888 neurodesktop_jupyter
    set /p=running - press ENTER key to shutdown and quit!
    docker stop neurodesktop_jupyter
    docker rm neurodesktop_jupyter
) || (
    echo "-------------------------"
    echo "Docker Build failed!"
    echo "-------------------------"
)