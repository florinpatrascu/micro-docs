## Configuring Micro

Micro depends on a YAML file for configuring framework components. This file must be in the application configuration folder and it has the name: `micro-config.yml`. Below are some configuration examples with in-line comments explaining the meaning of each element.

### Typical config file
This is the typical configuration file. It has one Template engine, [Velocity](http://velocity.apache.org/) in this case, and one dynamic content repository plus the mandatory `templates` repo. The name of the web app in this case is: **blog**, and the app will run in `development` mode. As a reminder, the cache is disabled in `development` mode.

    # the name of the web application
    name: blog
    # a short description of the application
    description: My Blog

    # defines the application dynamic content repositories
    repositories:
      # `content` is the name of the repository and the pages will be cached in 
      # the 'memCache' cache
      content: {path: views/content, cache: memCache}

      # the Templates repository. Used to define the reusable layouts of the web app
      templates: {path: views/templates, cache: memCache}

    # while optional, it is a good to have folder. Will contain all your scripting code
    # that can produce dynamic content for your pages. Using a different cache
    controllers: {path: controllers, cache: controllers}

    # The Micro cache system
    cache:
      # you can dedicate distinct cache spaces by simply naming them
      names: [memCache, partials, views, controllers]

      # the cache implementation (included with Micro and using the EHCache)
      class: ca.simplegames.micro.cache.DefaultCache

    # Micro can use multiple Template engines in the same time, the 
    # default one will be Velocity if none is defined
    template_engines:
      - engine:
          name: velocity
          class: ca.simplegames.micro.viewers.velocity.VelocityViewRenderer
          options:
              resource_cache_enabled: true
              resource_cache_interval: 15
              global_macro_library: global_library.vm
          default: true

    # Micro runs by default in `development` mode, you can specify here other modes:
    # - development, production or test.
    # This app will run in `production` mode
    MICRO_ENV: production

    # The welcome_file is a file name Micro will use for appending to a request for a
    # URL (called a valid partial request) that is not mapped to a web component.
    # Default is: 'index.html', if not declared here. You can also use an empty
    # string, just like this: 
    #    welcome_file: "" 
    # Be carefull with using empty strings for welcom files!
    welcome_file: "index.html"

    # optional mime types to overwrite the default.
    mime_types:
      .md: text/html; charset=utf8

This configuration file is mapped to the following [application folder layout](/microwebapp.md):

    app                            
     └ images 
     ...
     └ WEB-INF                    
       └ ...                      
       └ config                   
          └ extensions                   
            └ ...                   
          └ micro-config.yml      
       ...
       └ views                    
         └ content                
         └ templates              
       ...

With this configuration and layout, you will be ready to start immediately creating web content. And since Micro is already equipped by default with support for [internationalization](/internationalization.md), your pages can use different locales for creating content for specific countries and languages. The character encoding in Micro is `UTF-8`.

### A more advanced config file
The application below will have multiple Template engines enabled, so you can mix various template languages for generating dynamic content, more content repositories, including one that contains partial page fragments and will use Markdown documents as welcome files. It will use a dedicated cache for every repository. For simplicity, we will hide other configuration elements that are common to the configuration file described before.

    ...
    repositories:
      # the config element instructs the repository manager that pages in this
      # repository may have controllers associated and they have to be executed
      # before renderin the page
      content: {path: views/content, cache: contentCache, config: config, default: true}
      partials: {path: views/partials, cache: partials, config: config}
      templates: {path: views/templates, cache: memCache}

    controllers: {path: controllers, cache: controllers}

    cache:
      names: [memCache, partials, contentCache, controllers]
      class: ca.simplegames.micro.cache.DefaultCache

    template_engines:
      - engine:
          name: velocity
          class: ca.simplegames.micro.viewers.velocity.VelocityViewRenderer
          options:
              resource_cache_enabled: true
              resource_cache_interval: 15
              global_macro_library: global_library.vm
          default: true

      - engine:
          name: markdown
          class: ca.simplegames.micro.viewers.markup.MarkupViewRenderer

      - engine:
          name: freemarker
          class: ca.simplegames.micro.viewers.freemarker.FreemarkerViewRenderer
    ... 

These are two variations of the Micro configuration file. In the configurations above we consider the folder `views` for storing the repositories, but you can define your own naming convention. You can also name your content repositories differently than we do here, for example:

    repositories:
      content: {path: dynamic/content, cache: contentCache, config: config, default: true}
      includes: {path: dynamic/includes}
      markdown: {path: dynamic/markdown_documents}
      templates: {path: dynamic/templates, cache: memCache}

The fragment above is presuming your [application folder layout](/microwebapp.md) looks like this:

    my_markdown_site                            
     └ images 
     ...
     └ WEB-INF                    
       └ ...                      
       └ config                   
          └ ...                   
          └ ...                   
          └ micro-config.yml      
       ...
       └ dynamic                    
         └ content                
         └ markdown_documents               
         └ includes                
         └ templates              
       ...

Should be easy to configure a Micro web application :) 
