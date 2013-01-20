## Views

Views, probably the best known element of the Model View Controller pattern. It is a visual representation of various models defined within your application, like: Users, Products, list of items or partial model representations of these; or maybe just very basic structures such as: arrays, strings, hashes, etc. The View would visually represent the model attributes by highlighting or suppressing them, eventually using the mini-language offered by the Template Engine used. This is the place where the Developer meet the Designer. Micro is using a context for this meeting place; the `ca.simplegames.micro.MicroContext`. It is basically a thread-safe hash containing references to objects created by Micro or by the Developers through Controllers attached to the View.

Here's a bit of history: the MVC as explained by [Trygve Reenskaug](http://heim.ifi.uio.no/~trygver/themes/mvc/mvc-index.html), the inventor of the MVC, from a paper he published on December 10th, 1979:

>The essential purpose of MVC is to bridge the gap between the human user's mental model and the digital model that exists in the computer. The ideal MVC solution supports the user illusion of seeing and manipulating the domain information directly. The structure is useful if the user needs to see the same model element simultaneously in different contexts and/or from different viewpoints. The figure below illustrates the idea.

![Figure: MVC](http://heim.ifi.uio.no/~trygver/themes/mvc/MVC-2006.gif)(link to the [original source](http://heim.ifi.uio.no/~trygver/themes/mvc/mvc-index.html))

The View will therefore have to know about the attributes of the model it represents, and unless you're a Designer wearing multiple hats: Developer and Designer in the same time, then collaborating with the Developer is key when designing the Views.

### Convention over Configuration?
You’ve heard that Rails promotes “convention over configuration”, and that is ok, however with Micro we're twisting a bit this concept, and let us explain why.

You don't always need a Controller (or a list of actions) to be executed before rendering a web page. And because of this concern, the View in Micro can act alone without any Controller associated, the only model received being the MicroContext, from Micro itself. There is a subtle advantage to this: performance. For controller-less Views, Micro will not have to make any judgements about validating the controllers and instantiating them during the web request. While in Ruby, the foundation of Rails, this is relatively easily solved, in a compiled environment is not as easy. The performance gain in Micro is coming at the cost: you will have to decide if you want or not to have controllers associated with the View, but don't worry, it is not that hard, and the rule is simple.

### Views and Controllers
[Controllers](/controllers/) are associated with Views through a simple configuration file that has the name of the View and the extension: `.yml`. The View configuration file is stored in the [repository](repositories.md#content) where the View is, under the optional sub-directory named: `config`. Example:

Let's say we have a simple View in the main repository `content`, we call this View: hello.html

If the Micro repositories are defined as follows:

    repositories:
      content: {path: views/content}
      templates: {path: views/templates}

then our view will be in this path: `views/content/hello.html`. Using Velocity, we define this simple page as this:
    
    views/content/hello.html:
    -------------------------
    
    <p>
      Hello ${name}!
    <p/>

First we create a new scripting Controller (we can use any scripting engines supported by Micro, including compiled Java classes) and we save this controller in the `controllers` directory. This is the code of this controller (written in [Beanshell](http://www.beanshell.org/)):

    controllers/DescribeUser.bsh:
    -----------------------------

    context.put("name", "Sheppard Arterius");
    
 
Now let's associate the `DescribeUser.bsh` controller with the `hello.html` view. For that to happen, we need to create a `hello.yml` file under the `views/content/config` folder, a file that looks like this:

    views/content/config/hello.yml:
    ------------------------------    
    
    controllers:
      - controller:
          name: DescribeUser.bsh

Now every time a user will request `http://www.mysite.com/hello.html`, the `DescribeUser.bsh` controller will be executed and the object `name` will be available in the `hello.html` context.

The view configuration file allows you to overwrite the default site Template and to define arbitrary data structures that can be passed to the associated controllers, as well as defining multiple controllers that will be executed sequentially ordered the same way you defined them in the config file. Example:

    views/content/config/hello.yml:
    ------------------------------    
    
    template: userprofile
    controllers:
      - controller:
          name: FindUser.bsh
            options:
              roles: ["guest", "registered"]
              foo: bar
      - controller:
          name: DescribeUser.bsh
  
In the example above we tell Micro that `hello` View will use a different template than the default one; `userprofile`, respectively. And we also tell Micro that there are two controllers that will be executed in this order:
  
  1. FindUser.bsh
  1. DescribeUser.bsh

An important aspect worth noting here, is the fact that all the Controllers defined for a View, **share** the View context, so they can exchange objects among themselves and with the View itself. If for example the `FindUser.bsh` controller will put a `User` object into the context: `context.put("user", user);`, then the `DescribeUser.bsh` can use it and extract the name, instead of hardcoding it, as we did in our simple example before. In this scenario, the `DescribeUser.bsh` would look like this:

    controllers/DescribeUser.bsh:
    -----------------------------
    
    user = context.get("user");
    context.put("name", user != null? user.Name : "Joe Doe");      

Straightforward, we think?!

### Default View context objects
As mentioned before, the View will receive a thread-safe context already containing some important objects that Micro is providing **before** executing any controllers, in case there are any controllers defined for the View. These objects are:

  - [helpers](/helpers)
  - "log" - the global logger
  - "site" - the global SiteContext object
  - "request" - the pristine web request as received by the application
  - "rack_response" - the Response object that will be sent to the Rack
  - "params" - a hash containing the input parameters received with the request
  - the repository names (as declared in the `micro-config.yml`)
  - and more. See: [MicroContext](/microcontext.md), for more details.

  
    

