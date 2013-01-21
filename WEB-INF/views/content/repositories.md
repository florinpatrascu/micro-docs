## Repositories

A repository in Micro maps on web content folders, folder containing your web resources; static or dynamic. Micro requires minimum two important repositories: `content` and `templates`. 

### Defining repositories
All the repositories are defined in the `micro-config.yml` file, and here is an excerpt from that file:

    repositories:
      content: {path: views/content}
      templates: {path: views/templates}

(for a detailed description of the configuration file, please follow this [link](/config.md))

Let's talk about the two main repositories.

### <name id="templates"/>the Templates
The `templates` repository contain the files which are used by the web designers to provide the visual "shell" for your web site. Most sites will only have one template which is applied to all the pages within the web site. In the example above this file is located in the `views/templates` directory and is called `default.html`. You could also provide default site-wide templates for other types of content, Markdown for example, by putting an appropriate template file in the `templates` folder. In the case of Markdown you could call it `default.md` and then all requests which end with `.md` would use that primary template. The documentation web app for Micro (this) was built this way.

If you are familiar with [JPublish](http://code.google.com/p/jpublish/wiki/Templates) this concept is not completely foreign to you. Let's explore it.

As described before, templates are used by designers to provide the appearance of your web site. The Designers can work on a single template which can be applied to the whole site. Changes to the template will be reflected throughout the site without having to go through the tedious process of updating every single page. Additionally, because the template wraps around the page, as opposed to the page including parts of the template, template designers can be assured that their designs will remain intact throughout the site.

Typically templates will be placed in the directory referred by the `templates` repository. You can have many templates in this directory and you can even refer to templates which are in nested subdirectories.

Template names follow the format of **name.extension**. Micro expects a default template with the name `default` which is used on pages where no template is specified. For every named template you will have one version for each request type where the request type is indicated by the extension. Thus, the default template for HTML content would be found in `views/templates/default.html` whereas a template for `md` could be called `views/templates/default.md`. Micro automatically determines the appropriate template type at request-time based on the request path and file extension.

You can also override the default template on a page-by-page basis by inserting the following element in the View configuration for the specific page:

    template: template_name

The web pages are optionally defined as `views`, simple `.yml` configuration files in the `config` subdirectory under each repository folder. This is optional and it is required only when you want to add Controllers to a page or overwrite the default template.

Replacing template_name with the name of the template. Your template can be specified as a path relative to the templates root directory and must not include a file suffix.

Micro's template manager includes a cache which will store your templates in memory; the cache being disabled in development mode. This caching helps improve response time by reducing template loading.

The Templates can have their own View definition and have one or more controllers associated with them. This is done by having a configuration file in the same directory as the template file under the subdirectory: `views/templates/config`, with the template name and the extension `.yml`; this is the View configuration file. Therefore, for the template `default.html` the template configuration file would be: `default.yml`. The following is an example of a template configuration file:

`default.yml` View file:

    controllers:
      - controller:
          name: DefaultTemplate.bsh
          options:
            foo: bar

All the controllers will be executed **before** the template is rendered and the results obtained during the execution will be injected in the rendering context and available from there to your template engine, in the page.

As a performance optimization, you will have to inform Micro about your intentions of having the `config` folder in the `templates` repository. You do this by specifying it in the repository definition:

    repositories:
      templates: {path: views/templates, config: config}

and by creating the `config` folder in the root of the `views/templates` directory.

### <name id="content"/> the Content
All the web pages stored in various repositories are considered dynamic by default and processed at run-time by dedicated Template engines. Pages, containing html tags, or template specific language directives, are **pulled** and wrapped by the `default` template, unless the template name is specified by the developer/designer. This is how Micro is publishing content and it is similar with the original design of [JPublish](http://jpublish.org), probably a bit better ;) 

Micro can handle multiple repositories and they can each contain pages that can be pulled by the Templates as well as by other pages, this flexibility allowing the Designers to define the web pages with an extremely fine granularity. This procedure is similar with the [Partials](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials) in Rails.One should be careful with the level of fragmentation because it may be very hard to test the content once the final page is aggregated in the template. A future version of Micro will automatically embed a tag in your page when running in `development` mode so you can trace the content to the parent resource.

Let's use an example to help you understand how Micro is publishing content.

Fo example, we want to create this very simple html page:

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
       "http://www.w3.org/TR/html4/strict.dtd">

    <html lang="en">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    	<title>Powered ny Micro</title>
    </head>
    <body>
      <div id="header">
        <p>
          the Header 
        </p>
      </div>

      <div id="content">
        My site has only one page, for now.
      </div>

      <div id="footer">
        (c) Copyright ...
      </div>
    </body>
    </html>

But we want to break down the main sections of this page and handle the content dynamically. First we extract the default template. This is the content that will go into `views/templates/default.html`:

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
       "http://www.w3.org/TR/html4/strict.dtd">

    <html lang="en">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    	<title>Powered by Micro</title>
    </head>
    <body>
      <div id="header">
        $partials.get("header.html")
      </div>

      <div id="content">
        $content.get($path)
      </div>

      <div id="footer">
        $partials.get("footer.html")
      </div>
    </body>
    </html>

The template above is presuming your web application folder layout looks like this:

    my_app                            
     └ images 
     ...
     └ WEB-INF                    
       └ ...                      
       └ config                   
          └ ...                   
          └ micro-config.yml      
       ...
       └ views                    
         └ content                
         └ partials                
         └ templates              
       ...
       
and the `micro-config.yml` file defines the following repositories:

    repositories:
      content: {path: views/content, default: true}
      partials: {path: views/partials}
      templates: {path: views/templates}
    
We will return to the `weird` words prefixed with `$` and scattered throughout the extracted template. For now let's define the content that will be merged with the template. First we create the two partials, the: `header` and the `footer`, respectively. These are two `.html` files we create in the `views/partials` folder. Like this:

  - `views/partials/header.html`
  
        <p>
         the Header 
        </p>
      
  - `views/partials/footer.html`
    
        (c) Copyright ...
    
And then, in the root of the `views/content` folder, we create the main page: `index.html`, like this:

  - `views/content/index.html`
  
        My site has only one page, for now.

Now the magic happens. When you point your browser to your application, the template will pull all the three pages and merge them as a single html page that you see in your browser. Let's go back to the `weird` words in the the main template. As you probably know by know, Micro is using a variety of [Template Engines](/views/engines.md), and our default engine, the one used in our examples throughout this site, is: [Velocity](/views/engines.md#Velocity). You can learn more about these in the section dedicated to the [Template Engines](/views/engines.md). The `$` sign prefixed words are objects created by Micro and you will recognize two of them right away: `$partials` and `$content`. To access a repository from within a Velocity template you can refer to the repository by name since all repositories are automatically exposed to the template. The two names above are defined in the `micro-config.yml`, and it tells to the template from where to pull the page:

  - `$partials.get("header.html")`
    > this will produce the content of the `views/partials/header.html` file
    
  - `$content.get($path)`
    > this is a bit special. This line of Velocity will first look for an object called `content` which has already been made available to the Velocity engine. Once a reference to `content` is located, the `get()` method is called passing `$path` as the value; `$path` resolves to the current request path. If the requested page is `http://www.mysite.com/contact.html` then `$path` would equal `/contact.html` and if the request is `http://www.mysite.com/` then the path will be the `/index.html`.
    
  - `$partials.get("footer.html")`
    > this will produce the content of the `views/partials/footer.html` file

All these together will dynamically create your "index.html" page and the browser will receive this content:

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
       "http://www.w3.org/TR/html4/strict.dtd">

    <html lang="en">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    	<title>Powered by Micro</title>
    </head>
    <body>
      <div id="header">
        <p>
          the Header 
        </p>
      </div>

      <div id="content">
        My site has only one page, for now.
      </div>

      <div id="footer">
        (c) Copyright ...
      </div>
    </body>
    </html>
    
Since it is so easy, let's say you want to reuse the same template but for another page: `about_me.html`. The only thing you'll have to do is to create the new file in the `views/content/`. This is the file:

    I am Chuck Norris and I've been to Mars already; that's why there are no signs of life
    there. 

When you point your browser to `http://www.mysite.com/about_me.html` the browser will receive this result:

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
       "http://www.w3.org/TR/html4/strict.dtd">

    <html lang="en">
    <head>
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    	<title>Powered by Micro</title>
    </head>
    <body>
      <div id="header">
        <p>
          the Header 
        </p>
      </div>

      <div id="content">
        I am Chuck Norris and I've been to Mars already; that's why there are no signs of 
        life there.
      </div>

      <div id="footer">
        (c) Copyright ...
      </div>
    </body>
    </html>


And this is how Micro is publishing your dynamic content.

More details about the template rendering process can be found in the [Views](/views) section later in this guide.
