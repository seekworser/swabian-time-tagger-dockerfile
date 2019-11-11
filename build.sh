cd ./image
docker build --no-cache=true --rm -t seekworser/swabian-time-tagger --build-arg host_display=host.docker.internal:0 .