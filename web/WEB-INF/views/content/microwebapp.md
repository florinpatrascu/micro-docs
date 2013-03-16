## Web application layout

This is the typical layout of a Micro web application:

    app/                           - the application folder: /blog, /my_site, etc.
     └ <anything public; js, styles, images, etc.> 
     └ WEB-INF/                    - Servlet specific folder 
       └ classes/                  - compiled java filed
       └ lib/                      - libraries
       └ config/                   - configuration files
          └ extensions/            - a directory containing Micro extensions
            └ i18N.yml             - default localization configuration file
          └ locales/               - folder containing the localization files
            └ messages.properties  - English terms
          └ helpers/               - optional folder containing helpers definitions 
            └ my_helper.yml        - a user helper 
          └ routes.yml             - optional file defining your REST API
          └ application.bsh        - this is the startup controller  
          └ micro-config.yml       - Micro configuration file
       └ controllers/              - application controllers, scripting
       └ views/                    - repositories
         ├─ content/               - main repository
         └─ templates/             - main template files used as web main layouts
       └ web.xml                   - standard servlet configuration file, rarely edited.
        
Micro allows you to organize your files with greater flexibility, creating your own application folder structure. Those of you familiar with deploying Java web applications will recognize immediately the layout above; it is a standard exploded `.war` folder. There are 2 main sections which pretty much divide up the entire layout. The content directly inside the root `/` of the app, and then everything that’s inside the WEB-INF folder. The key difference between the two is that one is public, while the other one has protected access. It’s a violation of the specification for an application server to allow public access to anything in the `WEB-INF` folder of your application.

<span class="label label-info">WEB-INF</span>
Based on the Sun Microsystems Java Servlet 2.3 Specification, this directory contains the supporting Web resources for a Web application, including the web.xml file and the classes and lib directories. Which is why Micro's main active components are deployed in this folder. There is also a security aspect. A wrongly configured application server will not read from this folder (unless it is really badly configured).

 - <span class="label">/classes</span>
This directory is for utility classes, various 3rd party configuration files, and the Java compiler output directory. The classes in this directory are used by the application class loader to load the classes or other resources. You don't need to include this folder if it is empty.

 - <span class="label">/lib</span>
The supporting JAR files that your Web application references. Any classes in .jar files placed in this directory will be available for your Web application. This is the place where you put all of your web application’s third party jar files.

<span class="label label-info">config</span>
This folder contains various files used for configuring the Micro framework. Please follow this [link](/config.md/) for a detailed descriptions.

<span class="label label-info">views</span>
This folder contains the main [repositories](/repositories.md). The two most important repositories are: `templates` and `content`. You will learn later on that you can rename them and instruct Micro to use the new names.
 
 - <span class="label">/content</span>
For any web request, Micro will try to find the requested resource in this folder. For example, if someone is looking for a file named: `readme.html`, Micro will search this folder and if the file exists then the file will be rendered by a [Template Engine](/views/template_engines.md), pulled into the main site layout (another template in the `/templates` folder) and the result sent back to the user.
- <span class="label">/templates</span>
Templates are the files which are used by graphic designers to provide the layout of the web site and to eliminate the duplication of the content that can be reused. In Rails they are called [layouts](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts)

<span class="label label-info">controllers</span>
This folder is optional but important nonetheless. It may contain scripting code ([Controllers](/controllers/)) written in: [Beanshell](http://en.wikipedia.org/wiki/Beanshell), [Rhino JS](https://developer.mozilla.org/en-US/docs/Rhino) or [Ruby](http://www.ruby-lang.org/en/). In fact, Micro is using the [Bean Scripting Framework (BSF)](http://commons.apache.org/bsf/), an open source library which provides scripting language support within Java applications, and access to Java objects and methods from scripting languages. A dedicated page describes the functionality of the Micro [Controllers](/controllers/).

<span class="label label-info">web.xml</span>
The `web.xml` file is used for configuring Servlet based Java web applications and has a very basic functionality for Micro. In fact most of the time you will reuse the following web.xml:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE web-app
            PUBLIC "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
            "http://java.sun.com/dtd/web-app_2_3.dtd">

    <web-app>
        <filter>
            <filter-name>Micro</filter-name>
            <filter-class>org.jrack.RackFilter</filter-class>

            <init-param>
                <param-name>rack</param-name>
                <param-value>ca.simplegames.micro.MicroFilter</param-value>
            </init-param>

            <init-param>
                <param-name>ignore</param-name>
                <param-value>bootstrap,js,images,styles,favicon</param-value>
            </init-param>
        </filter>

        <filter-mapping>
            <filter-name>Micro</filter-name>
            <url-pattern>/*</url-pattern>
        </filter-mapping>
    </web-app>

#### JBoss only
If you're deploying the web application on JBoss, then you will need one more file in the `WEB-INF` folder, the: `jboss-web.xml` file, that can be configured this way:

   
    <?xml version="1.0" encoding="UTF-8"?>  
    <!DOCTYPE jboss-web PUBLIC "-//JBoss//DTD Web Application 2.3//EN"   
        "http://www.jboss.org/j2ee/dtd/jboss-web_3_0.dtd">  
  
    <jboss-web>    
       <context-root>/</context-root>    
    </jboss-web>  

The context-root element here basically tells JBoss to load up the application into the root context of the application server, all the calls to `http://localhost:8080/` will be resolved by your web application.
