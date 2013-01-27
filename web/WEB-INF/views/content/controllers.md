## Controllers

Controllers provide an optional way of exposing objects to the [Views](/views/). They can be authored in a variety of languages including Java (compiled), [Beanshell](http://www.beanshell.org/), server side [Javascript(Rhino)](http://www.mozilla.org/rhino/), [JRuby](http://jruby.org/) and any other scripting language supported by [Apache's Bean Scripting Framework](http://commons.apache.org/bsf/).

We've learned in the [Views](/views/) section, how to associate a controller or a set of controllers with the Views, through the view's configuration files.

## Implementing Controllers
To implement a Controller in Java you must implement the `ca.simplegames.micro.Controller` interface. Example:

    TestController.java file:
    -------------------------
    
    public class TestController implements Controller {
      protected static final Log log = LogFactory.getLog(TestController.class);

      @Override
      public void execute(MicroContext context, Map conf) throws ControllerException {
         final String canonicalName = TestController.class.getCanonicalName();
         context.put("class", canonicalName);
         log.info("Executing: " + canonicalName);
      }
    }

While the same code in scripting (Beanshell) will look like this:

    controllers/TestController.bsh file:
    -----------------------------------
    
    canonicalName = TestController.class.getCanonicalName();
    context.put("class", canonicalName);
    log.info("Executing: " + canonicalName);


All the controllers receive a thread-safe context, a shared instance of the `MicroContext` class. It is shared because the same instance is received by all the Controllers (and the Views) participating in the process of generating a response. This method allows you to chain controllers, compiled or scripting and to exchange objects through the context. What is in a context received by a controller?

### Default objects available in the context
When required to, Micro will create a new Controller instance and will pass two elements to the newly instantiated controller:
  
  - the MicroContext, `context`
  - a Map containing a set of configuration options described by the user

For the following controller definition:

    - controller:
        name: FindUser.bsh
          options:
            roles: ["guest", "registered"]
            foo: bar
the `FindUser.bsh` controller will receive a `configuration` object containing the keys: `roles` and `foo`, each of them associated with their corresponding values.

While a compiled controller will receive the configuration as a parameter of the `execute()` method, the scripted controllers will receive a `configuration` object in their execution context. Example:

    controllers/FindUser.bsh file:
    ------------------------------

    log.info(configuration.get("foo")); // will display: "bar""

    
  