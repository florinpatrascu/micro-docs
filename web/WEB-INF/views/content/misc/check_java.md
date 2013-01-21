## Micro Prerequisites

### Java.

To use Micro you need [Java 6 or later](http://www.oracle.com/technetwork/java/javase/downloads/index.html). Verify you have the `java` command available in your path. You can check this by simply typing the following command:

    $ java -version

And you should see something like this:
    
    java version "1.6.0_37"
    Java(TM) SE Runtime Environment (build 1.6.0_37-b06-434-11M3909)
    Java HotSpot(TM) 64-Bit Server VM (build 20.12-b01-434, mixed mode)
    
### Path and environment configuration
Micro is providing a simple command line interface (CLI) to help you creating new applications, start a local Micro application in server mode and deploy the web application. More about the CLI here: [The Micro console](/cli.md)

You should add the framework installation folder to your current path. For OSX, this means doing something like this:

    $ echo "export PATH=$PATH:/path/to/micro" >> ~/.profile

or edit your profile file and add this: 

    export PATH=$PATH:/path/to/micro

Now check if the micro cli is available:

    $ micro -h

If everything is in place and properly installed, you should see Micro displaying the help text for the available commands. Excerpt:

    $ ..... todo
    
todo: describe the path editing to allow Micro shell to be found and executed in command line mode