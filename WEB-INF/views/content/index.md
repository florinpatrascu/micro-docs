### Overview
Micro is a modular Model View Controller framework for web development, and it was designed with simplicity in mind. We hope Micro will help you develop web applications while increasing the fun quotient of programming as well.

Inspired from [Sinatra](http://www.sinatrarb.com/), Micro will help you creating web application in Java with very little effort.

#### Getting started

To use Micro you must have Java 6 available in your path. Verify that by simply executing the following command:

    $ java -version

And you should see something like this:
    
    java version "1.6.0_37"
    Java(TM) SE Runtime Environment (build 1.6.0_37-b06-434-11M3909)
    Java HotSpot(TM) 64-Bit Server VM (build 20.12-b01-434, mixed mode)
    
#### Installing Micro
Micro can be downloaded from Github and you will need just a few commands to make it available to your console.

    $ ...

#### Creating a new Micro web application
Create a new micro web application and start Micro with the embedded [web server](http://docs.codehaus.org/display/JETTY/About+Jetty):

    $ micro new web_app

A new directory `web_app` will be created and you can start using Micro right away:
    
    $ cd web_app
    $ ./bin start

You will see something like this:
    
    INFO ca.simplegames.micro.Micro -  _ __ ___ ( ) ___ _ __ ___ 
    INFO ca.simplegames.micro.Micro - | '_ ` _ \| |/ __| '__/ _ \ 
    INFO ca.simplegames.micro.Micro - | | | | | | | (__| | | (_) |
    INFO ca.simplegames.micro.Micro - |_| |_| |_|_|\___|_|  \___/  (v0.1)
    INFO ca.simplegames.micro.Micro - = a modular micro MVC Java framework
    .... 
    INFO org.mortbay.log - Started SelectChannelConnector@127.0.0.1:8080 

And you can visit your web application by pointing your browser to: [http://localhost:8080](http://localhost:8080)

We hope you'll enjoy writing web applications with **Micro**.

Thank you!    

### Special thanks
  - [JPublish.org](http://jpublish.org/) - a trusty framework. There are core concepts in Micro designed as continuations of the ideas developed for JPublish; Templates and Repositories, for example.
  - Many thanks to [Anthony Eden](https://github.com/aeden) for being an inspiring developer and a model for many of us
  - Many thanks to [Frank Carver](https://github.com/efficacy) for contributing ideas to the [JRack](https://github.com/florinpatrascu/jrack), many of these being ported back into JRack and used my Micro
  - [Spring framework](http://www.springsource.org/)
  - [Apache Wink](http://en.wikipedia.org/wiki/Apache_Wink)
  - to all our **contributors** and **supporters**
  
### License

    Copyright (c) 2012-2013 Florin T.Pătraşcu

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    