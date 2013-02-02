## Micro Documentation

This is the [Micro Documentation](http://micro-docs.simplegames.ca) web site, using the Micro framework itself for publishing.

These are the few steps you need to follow if you want to install this site on your local environment and eventually contribute to helping us improving the documentation.

### Setup

To run this web application you need [Java 6 or later](http://www.oracle.com/technetwork/java/javase/downloads/index.html). All the required libraries are included and Micro is distributed with its own web server included; [Jetty 6.2.x](http://jetty.codehaus.org/jetty/)

    $ git clone https://github.com/florinpatrascu/micro-docs.git
    $ cd micro-docs
    $ ./run.sh
    
or: `micro start`, if Micro is already available in your path.
    

You will see immediately the messages emitted by Micro, excerpt:
    
    -  _ __ ___ ( ) ___ _ __ ___ 
    - | '_ ` _ \| |/ __| '__/ _ \ 
    - | | | | | | | (__| | | (_) |
    - |_| |_| |_|_|\___|_|  \___/  (x.y.z)
    - = a modular micro MVC Java framework
    ...
   
And you can visit the app by pointing your browser to: `http://localhost:8080`

Or you can use start the app using `foreman`:

    $ foreman start

Micro will listen on port 5000 if launched with `foreman`.
    
### Creating content or editing existing one

Micro is able to use multiple [Template engines](http://micro-docs.simplegames.ca/views/engines.md) in the same time: Velocity, FreeMarker or Markdown, but for the documentation we're using the `.md` files; Markdown documents, respectively. You can edit files or add new ones while Micro is running because it is running in development mode and in development mode the cache is disabled.

### Official documentation

link: [Micro Documentation](http://micro-docs.simplegames.ca)

### License ###

    Copyright 2013 Florin T.PATRASCU

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
    or implied. See the License for the specific language governing
    permissions and limitations under the License.
    

