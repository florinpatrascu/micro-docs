## Helpers

Helpers are context utility objects that are available throughout the entire request processing chain the: models, controllers and views. The helpers are loaded at startup and automatically introduced in the view/controller context the moment a web request is received. They remain in the context until the response is finalized.

Micro is deliberately distributed with a relatively short list of helpers and the user is encouraged to write their own and eventually contribute the code to the Micro project. A list with the known helpers can be found here: [Helpers catalog](/helpers/)

### Defining helpers
The helpers are small utility libraries that ideally would be designed to have a single responsibility. All the helpers are defined in the: `config/helpers` folder, by simple `.yml` configuration files, one file per helper. Here is an example of a helper configuration file:

    WEB-INF/config/helpers/hello.yml file:
    -------------------------------------
    description: A very simple helper example
    class: ca.simplegames.micro.helpers.HelloHelper

    options:
      foo: bar

At startup, Micro is inspecting the `config/helpers` folder and loads all the helpers defined according to the `class` definition. In the example above, Micro will create a helper definition named: `hello` and will instantiate a `ca.simplegames.micro.helpers.HelloHelper` object every time a web request is received. The helper are then injected into the controllers/views context and made available by their names; a simple key value entry. 

Following the example above, a view will be able to use a helper like this (Velocity code):
    
    $hello
while a controller will have to use the context:

    context.get("hello");
    
Simply extend the `ca.simplegames.micro.Helper` class if you want to implement your own helper. A list with the known helpers can be found here: [Helpers catalog](/helpers/)
