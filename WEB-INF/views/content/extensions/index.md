## Extensions

Extensions provide helper or class methods for Micro applications. They are powerful components allowing the developers to customize and change the default behavior of a Micro web application.

### Background.
Writing extensions could be critical for some of you, therefore we will introduce here some knowledge of Micro's design.

Micro is a [JRack](https://github.com/florinpatrascu/jrack) component and it is basically providing a [RackResponse](https://github.com/florinpatrascu/jrack/blob/master/java/src/org/jrack/RackResponse.java) to a request made via the `call` method of the [JRack.java](https://github.com/florinpatrascu/jrack/blob/master/java/src/org/jrack/JRack.java) class.

### Initialization
Extensions are loaded from Micro's `config/extensions` folder being defined by simple .yml configuration files, one configuration file for each extension. As an example, Micro itself is using an extension for supporting the internationalization of the web application [i18N](/internationalization.md) and this is the configuration file: `config/extensions/i18N.yml`

    class: ca.simplegames.micro.extensions.i18n.I18NExtension
    intercept: {parameter_name: language, scope: "session, request, context"}
    default_encoding: utf-8
    fallback_to_system_locale: true
    resource_cache: 10
    base_names: [config/locales/messages]
    
**todo**: load the extensions in a preferred order

The extension name is: the file name itself; `i18N`, in the example above. There is only one element of this file that matters to Micro, the: `class`. The `class` contains the name of the Java object implementing that will be instantiated by Micro. Micro will instantiate the class and will call the `register` method, passing in the configuration file as a Map containing all the elements of that file. Implement `ca.simplegames.micro.Extension` and your extension is ready to go. Have a look at how `ca.simplegames.micro.extensions.i18n.I18NExtension` was implemented as a quick implementation example.

### Extending Micro

During the registration, an Extension has access to the following Micro core Managers:

  - the application configuration model, loaded from: `config/micro-config.yml`
  - the [SiteContext](/sitecontext.md/) or `site`

>
> work in progress
>
 
Next is a sequence diagram illustrating the concepts discussed above.

![micro-seqdiag-0.1](/images/micro-seqdiag-0.1.png)
Figure: [micro-seqdiag-0.1](/images/micro-seqdiag-0.1.png)

