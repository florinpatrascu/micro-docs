#!/bin/sh

# Start Micro with the embedded Jetty server.

java $OPT -cp $( echo WEB-INF/lib/*.jar WEB-INF/classes/*.xml . | sed 's/ /:/g') ca.simplegames.micro.WebServer . $1 $2 $3 $4 $5 $6
