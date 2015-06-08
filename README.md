# HHVM Docker Container

This is a Docker container for Facebook's [HHVM](http://hhvm.com/). The build is aimed at Dockerfile simplicity rather than efficiency, and as such uses the Ubuntu base image. This means that if you want an efficient and small image, you may want to look elsewhere, but this acts as a good drop-in replacement for PHP FPM.