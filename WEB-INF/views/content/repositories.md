## Repositories

A repository in Micro maps on web content folders, folder containing your web resources; static or dynamic. Micro requires minimum two important repositories: `content` and `templates`. 

### Defining repositories
All the repositories are defined in the `micro-config.yml` file, and here is an excerpt from that file:

    repositories:
      content: {path: views/content}
      templates: {path: views/templates}

(for a detailed description of the configuration file, please follow this [link](/config.md))

Let's talk about the two main repositories.

### <name id="templates"/>Templates
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

### Content
Content in other repositories than `templates` should not include the html, head and body tags. This content is "pulled" my the Template and wrapped by the Template.



