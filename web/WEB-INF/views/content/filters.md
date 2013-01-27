## Filters

There are two type of filters: `before` and `after`. Similarly to [Sinatra](http://www.sinatrarb.com/intro.html#Filters), the filters are evaluated before each request within the same context as the routes will be and can modify the request and response.

### Defining Filters
Filers are defined in the `config/filters.yml` file and they are loaded by Micro at start-up. You will have to restart the Micro server instance after changing this file. A future Micro release will reload this file every time after an update was made in development mode.

Example of filters:

    - before:
        path: /private/repositories/{name}
        controller: admin/CheckCredentials.bsh
        options:
          roles: [admin, root]

    - before:
        path: /download
        controller: my.controllers.security.Admin

    - after:
        path: /download
        controller: logging/LogDownloadActivity.bsh
        options:
          events: [errors, success]

As you can see from the example above, the filters are acting as Controller wrappers that are evaluated before any Controllers and after the response was created and Micro is about to return the call. The filters are evaluated in the same order as they are defined; first the `before` group and then the `after` group, respectively.

You can specify a `path` causing the filters to be evaluated only if the request path matches that pattern. Or you can leave the `path` undefined and the Filter will be evaluated before or after each request. Something like this:

    - before:
        controller: filters/StickyFilter.bsh    

To implement a custom Filter, you must implement the `ca.simplegames.micro.Filter` interface.
