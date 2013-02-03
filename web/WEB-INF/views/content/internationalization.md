## Internationalization (I18n)

Are you ready to localize your web application into additional languages? This guide will walk you through the localization (i18N) support available in Micro and will teach you how to internationalize a Micro application right from the start. In Micro the localization support is implemented as an [extension](/extensions.md) and it is an optional feature enabled by default.

### Getting started / La mise en route / Einstieg
First make sure you have the `i18n` extension loaded in the system. The configuration file is in `config/extensions/i18N.yml`, and it looks like this:

    #alias: L10n
    class: ca.simplegames.micro.extensions.i18n.I18NExtension
    intercept: {parameter_name: language, scope: "session, request, context"}
    default_encoding: utf-8
    resource_cache: 10
    base_names: [config/locales/messages]
    
This file is instructing Micro about the following aspects:

  - `intercept` - declares a parameter with a name defined by the user: `language` in this case, parameter that can be transmitted through any of these Micro components: `session`, `request` or `context`. For example, the link: `http://mysite.com/about/index.html?language=fr`, will use the French localization for displaying the `about/index.html` page.
  - `default_encoding` - the encoding used by the i18N extension. We encourage you to leave it as is: `utf-8`, respectively. Read more about encoding [here](http://en.wikipedia.org/wiki/UTF-8).
  - `resource_cache` - how many seconds the localization properties will be cached before reloading the definitions.
  - `base_names` - the location and name prefix for the properties files containing the translated text. With this configuration, Micro will load properties from the following files: `config/locales/messages_en.properties` for English, `config/locales/messages_de.properties` for German, and so on.

Second, verify that the `i18N` extension is required by your application. You can do that by simply adding few lines of code in the `config/application.bsh` startup controller. Example of enabling the `i18N` extension:

    excerpt from the config/application.bsh file:
    --------------------------------------------
    
    site.ExtensionsManager
        .require("i18N");

If successfully loaded, Micro will display a simple startup message when the application is instantiated. Look for these messages in your server log:

    INFO ... .micro.SiteContext - Extensions:
    INFO ... .micro.SiteContext -   i18N, loaded.

### Localize yourß site
Say you have a web page that contains a some text that has to be presented in multiple languages, the: `header.html`, a page you want to include and reuse in your templates. We will use the Velocity template language for the next few examples. This is the initial version of the `header.html`, its static version:

    header.html:
    ------------
    
      <p>Hello World!</p>
      
Now let's spice it up with some dynamic content.

      <p>#i18N("hello_world")</p>

Where `#i18N` is a Velocity [macro](http://people.apache.org/~henning/velocity/html/ch07.html) provided by Micro to help you write cleaner i18N code in your views. The `#i18N` expects a key (or a list with keys) that will be used to look up the translation in the properties files; in this case the key being: `hello_world`.

Translate the `hello_world` key in the following languages and store them in the appropriate properties files in the `config/locales/` folder. Example.

            path           | language |    content
    ----------------------------------|-----------------------------------
    messages_en.properties | English  | hello_world=Hello World!
    messages_fr.properties | French   | hello_world=Bonjour tout le monde!
    messages_de.properties | German   | hello_world=Hallo Welt!
    messages_gr.properties | Greek    | hello_world=γειά σου κόσμος
    
You don't have to restart the Micro web application, the changes will be available right away. Visit your page containing the `header.html` and you should see:

    <p>Bonjour tout le monde!</p>   
    
for a page where you specified the French language as a request parameter: `http://localhost/index.html?language=fr` or this:

    <p>Hallo Welt!</p>
if the request parameter was specifying the German language: `http://localhost/index.html?language=de`

There is a full example in the Micro examples repository at Github, see the [Hello World](https://github.com/florinpatrascu/micro-examples/tree/master/hello_world) web application for how the `i18N` support is used. 

**Success** / **Bonne chance!** / **¡buena suerte**

Have fun localizing your site!

