#!/bin/sh

# Start Micro with the embedded Jetty server.
OPT='-Dnet.sf.ehcache.skipUpdateCheck=true -Xmx384m -Xss512k -XX:+UseCompressedOops'
java $OPT -cp $( echo libs/*.jar . | sed 's/ /:/g') ca.simplegames.micro.WebServer web 8080 $1 $2 $3 $4 $5 $6
