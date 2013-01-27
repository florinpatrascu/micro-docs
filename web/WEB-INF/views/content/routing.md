## Micro and REST
A `Route` in Micro is an http method paired with a URL-matching pattern; same as [Sinatra](http://www.sinatrarb.com/intro#Routes). Routes are defined in the `config/routes.yml` as simple Controllers/Views-to-URL-patterns bindings. The Java ecosystem is full with cool web development frameworks that are using annotated code for implementing RESTful support. We are taking a different approach in Micro: declaring routes in a simple configuration file. This way you don't have to code anything in Java, nor compile anything. A Designer will appreciate this support in the situation where he writes SEO friendly web resources, and yes, he doesn't have to learn Java. Example:

    config/routes.yml file:
    -----------------------
    
    - route: "/{image_file}.{type: png|jpg|jpeg|txt}"
      method: get, head
      controller:
        name: ca.simplegames.micro.controllers.BinaryContent
        options: {
          mime_types: { .txt: "text/plain;charset=UTF-8" }
        }

    - route: /system/info
      controller:
        name: ca.simplegames.micro.controllers.StatsController

    - route: /system/test
      method: get
      controller:
        name: demo/Demo.bsh
        options: {foo: bar}
      view:
        repository: content
        path: system/demo.json

    - route: /hello/{name}
      method: get, post, head
      controller:
        name: test/Hello.bsh
    
    
This is how you can declare [RESTful](http://en.wikipedia.org/wiki/Representational_state_transfer) services, serving dynamic contents as **resources** or SEO friendly links in Micro.

### Route, in detail.
Let's talk about the `route` definition. We'll use this example:

    - route: /system/test
      method: get
      controller:
        name: demo/Demo.bsh
        options: {foo: bar}
      view:
        repository: content
        path: system/demo.json

In the definition above Micro will evaluate the `demo/Demo.bsh` controller and merge its resulting models by rendering the View `system/demo.json` from the `content` repository. This will happen for every web request with a URL that matches the route: `/system/test`, having the [Request method](http://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html): `GET`, any other request method, such as: `POST`, `HEAD`, etc. will be ignored.

Notable config elements:

  - `route` - the URL-matching pattern. Route patterns may include named parameters, accessible via the `params` hash in the Micro `context`.
  - `method` - a comma separated list with the request methods accepted by the route. Example: `get`, `head`, `post`, `delete`. Default: `any`, if `method` is not specified.
  - `controller` - an optional structure defining a Micro controller that will be evaluated for the route. The `controller` is optional and can be replaced by a simple view; see below. The `options` structure will be transmitted to the controller as the `configuration` parameter.
  - `view` - a template or simple html resource, can be static text or any valid web resource. You must specify the repository where the view is stored and the path to the view. The `view` is an optional route configuration element, some developers preferring to decide about the views in their controller implementation. 

The routes are evaluated in the same order as they are defined, from top to bottom, and they will be evaluated for all the matching URLs.

While a simple implementation, the Routing in Micro is quite powerful and flexible, allowing you to define complex route matching rules. As a technical detail, Micro is currently embedding the [Apache Wink](http://incubator.apache.org/wink/) library, and we are planning to extend this integration in the near future. Probably reading about [Resource Matching](https://cwiki.apache.org/WINK/53-resource-matching.html) in Wink is a good place to start for Developers.
