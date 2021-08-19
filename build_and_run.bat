docker build -t neurodesk . --file Dockerfile_focal_base && (
    echo "Starting:"
    @REM sudo docker run -d --privileged --name vnm -v /vnm:/vnm -e RESOLUTION=1600x960 -e USER=neuro -p 6080:80 -p 5900:5900 vnm:latest
    @REM docker run -d --name neurodesk -p 8888:8888 neurodesk
    docker run -it --name neurodesk -p 8888:8888 neurodesk
    set /p=running - press ENTER key to shutdown and quit!
    docker stop neurodesk
    docker rm neurodesk
) || (
    echo "-------------------------"
    echo "Docker Build failed!"
    echo "-------------------------"
)