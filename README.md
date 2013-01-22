### Micro Documentation

This is the Micro Documentation web site, using the Micro framework itself for publishing.

These are the few steps you need to follow if you want to install this site on your local environment and eventually contribute to helping us improving the documentation.

### Setup

To run this web application you need is [Java 6 or later](http://www.oracle.com/technetwork/java/javase/downloads/index.html). All the required libraries are included and Micro is coming with its own web server included; Jetty 6.2.x

    $ git clone https://florin@bitbucket.org/florin/micro-docs.simplegames.ca.git
    $ cd micro-docs.simplegames.ca.git
    $ ./run.sh

You will see immediately the messages emitted by Micro, excerpt:
    
    -  _ __ ___ ( ) ___ _ __ ___ 
    - | '_ ` _ \| |/ __| '__/ _ \ 
    - | | | | | | | (__| | | (_) |
    - |_| |_| |_|_|\___|_|  \___/  (v0.2)
    - = a modular micro MVC Java framework
    ...
    - Started SelectChannelConnector@127.0.0.1:8080 
And you can visit the app by pointing your browser to: `http://localhost:8080`

Or you can use start the app using `foreman`:

    $ foreman start

in this case Micro will listen on port 5000, unless you decide otherwise.
    
### Creating content or editing existing one

Micro is able to use multiple Template engines in the same time: Velocity, FreeMarker or Markdown, but for the documentation we're using the `.md` files; Markdown documents, respectively. You can edit files or add new ones while Micro is running because it is running in development mode and in development mode the cache is disabled.
