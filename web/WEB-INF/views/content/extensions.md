## Extensions

Extensions provide helper or class methods for Micro applications. They are powerful components allowing the developers to customize and change the default behavior of a Micro web application. For a list with the existing extensions or contributed extensions, please follow this link: [Extensions catalog](/extensions/)

### Background.
Writing extensions could be critical for some of you, therefore we will introduce here some knowledge of Micro's design.

Micro is a [JRack](https://github.com/florinpatrascu/jrack) component and it is basically providing a [RackResponse](https://github.com/florinpatrascu/jrack/blob/master/java/src/org/jrack/RackResponse.java) to a request made via the `call` method of the [JRack.java](https://github.com/florinpatrascu/jrack/blob/master/java/src/org/jrack/JRack.java) class.

### Initialization
Extensions are loaded from Micro's `config/extensions` folder, an extension being defined by a simple `.yml` configuration file, one configuration file for each extension. Extensions can be distributed as a folder containing various components, such as custom views and user controllers. The simple rule being: name your extension folder with the same name as the extension `.yml` file. Example:

    extensions/
    ├── cache_admin/
    ├── cache_admin.yml

Micro itself is using an extension for supporting the internationalization of the web application [i18N](/internationalization.md) and this is the configuration file: `config/extensions/i18N.yml`

    class: ca.simplegames.micro.extensions.i18n.I18NExtension
    intercept: {parameter_name: language, scope: "session, request, context"}
    default_encoding: utf-8
    fallback_to_system_locale: true
    resource_cache: 10
    base_names: [config/locales/messages]
    
The extension name is: the file name itself; `i18N`, in the example above. There is only one element of this file that matters to Micro, the: `class`. The `class` contains the name of the Java object implementing that will be instantiated by Micro. Micro will instantiate the class and will call the `register` method, passing in the configuration file as a Map containing all the elements of that file. Implement `ca.simplegames.micro.Extension` and your extension is ready to go. Have a look at how `ca.simplegames.micro.extensions.i18n.I18NExtension` was implemented as a quick implementation example.

The extensions are used by Micro only if they are required by you. To specify the extensions you need in your application, edit the application startup controller: `config/application.bsh`, and enumerate the extensions you want:
    
    site.ExtensionsManager
        .require(<extension_name>)
        .require(<extension_name>)
        . ...
        .require(<extension_name>);

Example of loading just the localization support:

    site.ExtensionsManager
        .require("i18N");

This technique will allow you to control your extensions' load order, in case they should be loaded in regards to other, related, extensions.

### Extending Micro

During the registration, an Extension has access to all the Managers used by Micro. Please see the [site](/sitecontext.md/) documentation for details. The following objects are also available:

  - the name of the Extension, collected from the configuration name
  - the application configuration model, loaded from: `config/micro-config.yml`

An Extension can define new Controllers (via the Helper model), or add its own [Repositories](/repositories.md), create new REST Routes or simply participate as a Singleton in the Rack response process. As an Extension developer you have maximum access to Micro; please develop responsible :) The [Cache-admin](https://github.com/florinpatrascu/micro-extensions/tree/master/cache_admin) extension from Micro's extensions repository, is a good example to start with. We will use the `cache-admin` code to explain some of the next topics.

**1. Extending with Controllers** 

This is business as usual, the controllers (or actions), being the muscles of any MVC framework. With Micro you can quickly start prototyping your controllers using any of the supported scripting engines, and finalize them as Java classes that you can compile and distribute together with your extension. To implement a Micro extension, you can use scripting as well as compiled Java code. If you're using compiled code, then pack your classes as a `.jar` library. You can put your library in the `lib/` folder. Any scripting controllers will go inside the `controllers` folder. Example: 

      extensions/
      ├── cache_admin
      │   ├── LICENSE
      │   ├── README.md
      │   ├── controllers
      │   │   ├── CacheAdminRouteController.bsh
      │   │   └── CacheInfo.bsh
      │   ├── lib/ # <-- add your libraries and dependencies here
      │   │   ├── LICENSE
      │   │   └── cache_admin-0.1.1.jar
      │   ├── src
      │....
      ├── cache_admin.yml
      ...

<span class="label label-important">Heads up!</span>

 - any `.jar` files from the `lib/` folder will be added by Micro to the webapp's `classpath` when the user requires your extension. 
 - if you're using scripting controllers then you will have to register your `controllers/` path with the `MicroControllerManager`, just like this: 

  
      site.getControllerManager() 
         .addPathToControllers(new File(extensionPath, "/controllers"));         

Your controllers are now available throughout the entire Micro web application.
       
**2. Extending with Routes** 

This is again very easy; using the same example: `cache-admin`, as a model.

Say you want to bind your extension to a specific REST-like path. The `cache-admin` extension is doing that by declaring a route in the `cache_admin.yml` file: 

    routes:
      - route: /cache/
        controller:
          name: CacheAdminRouteController.bsh    

and by passing its own `routes` model to the RouteManager, when the extension is loaded: 

    cache_admin/src/.../AdminExtension.java.java file (excerpt):
    ------------------------------------------------------------
    
    for (Map<String, Object> routeMap : 
           (List<Map<String, Object>>)configuration.get("routes")) {
        
        try {
            String routePath = (String) routeMap.get("route");
            Route route = new RouteWrapper(routePath, routeMap);
            site.getRouteManager().add(route); // <-- route added
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

The `CacheAdminRouteController.bsh` controller will be evaluated for every request matching the `/cache/`.
    
**3. Extending with new Repositories** 

    File extensionPath = new File(site.getApplicationConfigPath(),
                                     "/extensions/cache_admin");
    Map<String, Object> myRepos = configuration.get("repositories");
    
    site.getRepositoryManager()
       .addRepositories(extensionPath, myRepos);
    
where: `myRepos`, is a configuration element from your `.yml` configuration file, example:

    repositories:
      ca_content:
        path: web/views
        config: config
      ca_templates:
        path: web/templates
    
   
**4. Extending the web content** 

Having your own content repositories registered, you can respond to the web requests by rendering various views defined by your extension. The trick being to intercept the appropriate request and to overwrite Micro's `default content` and `templates repositories` on the fly. You do that by injecting your repos into the current `context`, example:

    context.setTemplatesRepositoryName("ca_templates");
    context.with(Globals.MICRO_DEFAULT_REPOSITORY_NAME, "ca_content");
    context.with(Globals.PATH, path);

Micro will understand the above and will try to find the content in your extension. See the `cache-admin` extension for how all these work together.

Again, check the full example of the [Cache admin](https://github.com/florinpatrascu/micro-extensions/tree/master/cache_admin) extension provided in the micro-extensions Github repository.

Please feel free to send us a pull request with your own extensions, if you want them to be part of the main Micro distribution, thank you.

Good luck!

________

*Miscellaneous*

This is a sequence diagram to help you understand how Micro is evaluating a web request and what components are used.

![micro-seqdiag-0.1](/images/micro-seqdiag-0.1.png)
Figure: [micro-seqdiag-0.1](/images/micro-seqdiag-0.1.png)

