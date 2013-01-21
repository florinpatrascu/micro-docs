### Micro Documentation

This is the Micro Documentation web site, using the Micro framework itself for publishing.

These are the few steps you need to follow if you want to install this site on your local environment and eventually contribute to helping us improving the documentation.

### Setup

To run this site all you need is Java >=6. All the required libraries are included and Micro is coming with its own web server included; Jetty. We will provide Maven support in the near future.

    $ git clone https://florin@bitbucket.org/florin/micro-docs.simplegames.ca.git
    $ cd micro-docs.simplegames.ca.git
    $ ./run.sh

You will see immediately the messages emitted by Micro, excerpt:
    
    INFO ca.simplegames.micro.Micro -  _ __ ___ ( ) ___ _ __ ___ 
    INFO ca.simplegames.micro.Micro - | '_ ` _ \| |/ __| '__/ _ \ 
    INFO ca.simplegames.micro.Micro - | | | | | | | (__| | | (_) |
    INFO ca.simplegames.micro.Micro - |_| |_| |_|_|\___|_|  \___/  (v0.1)
    INFO ca.simplegames.micro.Micro - = a modular micro MVC Java framework
    .... 
    INFO org.mortbay.log - Started SelectChannelConnector@127.0.0.1:8080 
    
### Creating content or editing existing one

Micro is able to use multiple Template engines in the same time: Velocity, FreeMarker or Markdown, but for the documentation we're using the `.md` files; Markdown documents, respectively. You can edit exiting files or add new files while Micro is running because it is running in development mode and in development mode the cache is disabled.
Micro is able to use multiple Template engines in the same time: Velocity, FreeMarker or Markdown, but for the documentation we're using the `.md` files; Markdown documents, respectively. You can edit exiting files or add new files while Micro is running because it is running in development mode and in development mode the cache is disabled.
