#!/bin/sh

# Start Micro with the embedded Jetty server.

java $OPT -cp $( echo libs/*.jar classes/*.xml . | sed 's/ /:/g') ca.simplegames.micro.WebServer web 8080 $1 $2 $3 $4 $5 $6
