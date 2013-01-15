## Micro web application

A Micro web application is a directory having the following simple structure:

    app                            - the application folder: /blog, /my_site, etc.
     └ <anything public; js, styles, images, etc.> 
     └ WEB-INF                     - 
       └ classes                   - compiled java filed
       └ lib                       - libraries
       └ config                    - configuration files
          └ extensions             - a directory containing Micro extensions
            └ i18N.yml             - the configuration for the default localization support
          └ locales                - folder containing the localization files
            └ messages.properties  - English terms
          └ helpers.yml            - optional file containing helpers definitions 
          └ routes.yml             - optional file defining your REST API
          └ application.bsh        - this is a startup controller  
          └ micro-config.yml       - Micro's main configuration file
       └ controllers               - application controllers, scripting
       └ views                     - repositories
         └ content                 - main repository
         └ templates               - the main templates used as layout
       └ web.xml                   - standard servlet configuration file, rarely edited.
        
The structure above is the proposed layout, Micro allowing you to organize your files with a greater flexibility. THose of you familiar with deploying Java web applications will recognize immediately the layout of a 

<span class="label label-info">WEB-INF</span>
Based on the Sun Microsystems Java Servlet 2.3 Specification, this directory contains the supporting Web resources for a Web application, including the web.xml file and the classes and lib directories. Which is why Micro's main active components are deployed in this folder. There is also a security aspect. A wrongly configured application server will not read from this folder, unless is really bad configured.

 - <span class="label">/classes</span>
This directory is for utility classes, various 3rd party configuration files, and the Java compiler output directory. The classes in this directory are used by the application class loader to load the classes or other resources.

 - <span class="label">/lib</span>
The supporting JAR files that your Web application references. Any classes in .jar files placed in this directory will be available for your Web application

<span class="label label-info">views</span>
This folder contains the main [repositories](/repositories.md). The two most important repositories are: `templates` and `content`. You will learn later on that you can rename them and instruct Micro to use the new names.
 
 - <span class="label">/content</span>
Whenever there is a web request, Micro will try to find the required resource in this folder. For example, if someone is looking for a file named: `readme.html`, Micro will search this folder and if the file exists then the file will be rendered by a [Template Engine](/views/template_engines.md), pulled into the main site layout (another template in the `/templates` folder) and the result sent back to the user.



