## The Micro console

Micro is providing a limited set of command line tools to help you quickly creating a new web application, start it in server mode for quickly prototyping and for deploying the app to the cloud. It is a very early support currently in development but please stay tuned and follow this page for updates.

The command line for Micro is: `micro`, and provided you have [installed properly](/misc/check_java.md#cli_path/) the framework, the following functions are available:

    $ micro new 
    $ micro start 
    $ micro deploy (not yet implemented)   

#### New
Creating a new web application. Go to a folder dedicated to creating projects, say `projects` in your home directory and run the `new` micro command, followed by the name of the application:

    $ cd ~/projects
    $ micro new hello

A new folder is created: `hello`, and it contains a typical Micro folder structure with everything you need to start developing a web site. This is the resulted layout:

    hello
     └ js
     └ styles
     └ images                     
     └ WEB-INF                    
       └ classes                  
       └ lib                      
       └ config                   
          └ ...       
          └ micro-config.yml      
       └ controllers              
       └ views                    
         └ content                
         └ templates              
       └ web.xml                  

#### Start
You can start Micro in server mode. Micro is using the popular Jetty web-server under the hood. Go to the newly created `hello` folder and start the server:

    $ cd hello
    $ micro start

You will see immediately the following message (simplified, for brevity):

     _ __ ___ ( ) ___ _ __ ___ 
    | '_ ` _ \| |/ __| '__/ _ \ 
    | | | | | | | (__| | | (_) |
    |_| |_| |_|_|\___|_|  \___/ 
    = a modular micro MVC Java framework

    Application name: Hello
         description: A Hello world web application
    Template engines:
     engine: velocity, class: ...velocity.VelocityViewRenderer, default.
    Repositories:
     ** 'content'
       - path....: '~/projects/hello/WEB-INF/views/content'
       - renderer: 'velocity'
     ** 'templates'
       - path....: '~/projects/hello/WEB-INF/views/templates'
       - renderer: 'velocity'
    Extensions:
      i18N, loaded.
    Welcome file is: 'index.html'
    Application running in: 'development' mode
    
    Started SelectChannelConnector@127.0.0.1:8080

You can point your browser to `http://localhost:8080` and you should see:

    Welcome to Micro!
    
#### Deploy
Your web application can be packed in a special format and deployed to the cloud. Provided you have an account with Heroku, the following command will deploy your `hello` web application to Heroku.
    
    $ cd ~/projects/hello
    $ micro deploy heroku (not yet implemented)

Please follow this [link](/micro_for/heroku.md/) for more details about deploying a Micro web application at Heroku.

More details will be added as we improve the command line tools for Micro.
    