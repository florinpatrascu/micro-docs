## Controllers

Controllers provide an optional way of exposing objects to the [Views](/views/). They can be authored in a variety of languages including Java (compiled), [Beanshell](http://www.beanshell.org/), server side [Javascript(Rhino)](http://www.mozilla.org/rhino/), [JRuby](http://jruby.org/) and any other scripting language supported by [Apache's Bean Scripting Framework](http://commons.apache.org/bsf/).

We've learned in the [Views](/views/) section, how to associate a controller or a set of controllers with the Views, through the view's configuration files.

The controllers associated with the Views are evaluated **before** the View is rendered by the Template engine, the objects (models) resulting from the controllers being merged with the page content.

### Implementing Controllers
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


All the controllers receive a thread-safe context object, a shared instance of the `MicroContext` class, from now on referred to as the: `context`. It is shared because the same instance is received by all the Controllers (and the Views) participating in the process of generating a response. This method allows you to chain controllers, compiled or scripting ones, and to exchange objects through the `context`. What objects are in the `context` received by a controller?

### Default objects available in the context
When required to, Micro will create a new Controller instance and will pass two elements to the newly instantiated controller:
  
  - the MicroContext, `context`
  - a Map containing a set of configuration options described by the user

therefore according to the following controller definition:

    - controller:
        name: FindUser.bsh
          options:
            roles: ["guest", "registered"]
            foo: bar
the `FindUser.bsh` controller will receive a `configuration` object containing the keys: `roles` and `foo`, each of them associated with their corresponding values.

While a compiled controller will receive the configuration as a parameter of the `execute()` method, the scripted controllers will receive a `configuration` object in their execution context as a "pre-available" instance. Example:

    controllers/FindUser.bsh file:
    ------------------------------

    log.info(configuration.get("foo")); // will display: "bar"
    
in the example above `log` and `configuration` are "pre-available" objects, the developer doesn't need to instantiate them anymore.
    
The following objects are almost<sup>1</sup> guaranteed to be available in the `context`:

  - `log` - the main Micro logger, or the controller's own logger<sup>2</sup>
  - `site` - the global `SiteContext` instance, for getting access to Micro's main components, such as the: ExtensionManager, HelperManager, user global attributes and so on.
  - `request` - the `HttpServletRequest`
  - `rack_input` - a hash containing the pristine `JRack` input parameters
  - `rack_response` - Micro's Response object, the one that will be returned to the rack
  - `path` - the path calculated from the current request
  - `MICRO_ENV` - a string defining the mode Micro runs in; `production`, `test` or `development`
  - `params` - a hash containing the input parameters aggregated from GET/POST requests or from parametrized paths, such as routes in RESTful use cases. We encourage the Developers to create a better [helper](/helpers.md) for handling the **params** if the included support is not satisfactory enough.
  - `rack.logger` - JRack's own logger, for situations where the DevOps may want to log system messages differently. A rare use case but it may happen.
  - *and more* ...

We mentioned above just the main objects available in the `context`, you're encouraged to check the source code for learning what other interesting animals lurk in the magical **"Lake of Context"** at runtime ;)

### Testing Controllers
We will come back to this topic in the [Micro For Developers](/micro_for/developers.md/) section, for now we just want to show you how easy is to test a View and its Controller(s) in a simple [unit](https://github.com/KentBeck/junit) test.

    // created a reusable Micro site instance
    public static micro = new Micro("files", null, "../../lib");
    ...
    
    @Test
    public void testSomeDynamicContent() throws Exception {
        Context<String> input = new MapContext<String>()
                .with(Rack.REQUEST_METHOD, "GET")
                .with(Rack.PATH_INFO, "/result.html")
                .with(Rack.PARAMS, Collections.singletonMap("exp",
                        new String[]{URLEncoder.encode("2+2", Globals.UTF8)}));

        RackResponse response = micro.call(input);
        Assert.assertTrue("Can't parse/evaluate the request parameters",
                RackResponse.getBodyAsString(response).contains("=4"));
    }
    
The test above running agains this View:

    The `result.html` Velocity template:
    ------------------------------------
    
    =$!{result}

a View associated with a Controller implemented like this (example):

    expression = URLDecoder.decode(
      context.get(Globals.PARAMS).get("exp")[0], Globals.UTF8);

    // I know we're wasting resources, but it is for testing the
    // chained Scripting managers
    ScriptEngineManager manager = new ScriptEngineManager();
    ScriptEngine engine = manager.getEngineByName("js");
    context.with("result", engine.eval(expression));
    

Testing should be easy, we hope?!

<hr>
*Notes:*
<small>
  

 1. Micro allows the Designers/Developers to decide if they want to keep or overwrite the `context` objects. It seems like a bad idea, and some could complain that system objects (their keys, respectively) should be protected somehow, but it is not.
 2. For controllers compiled from Java, the Developers can define their own loggers and while this is true in the scripting world too, we decided to tune the scripting loggers to have the same name as the script defining the controllers; a neat debugging feature that we hope you'll appreciate.

</small>