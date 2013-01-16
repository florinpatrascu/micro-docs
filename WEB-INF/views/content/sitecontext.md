## The SiteContext
class: `ca.simplegames.micro.SiteContext`

The SiteContext class contains information about a Micro site and it is unique per web application. Can be used to store global variables that are available to the entire Micro framework, and it is available as the: `site` variable in every [MicroContext](#microcontext). Through the `site` one can get access to the following Micro core components:

  - CacheManager
  - AppConfig
  - BSFEngine
  - CacheManager
  - ControllerManager
  - HelperManager
  - Log
  - RepositoryManager
  - RouteManager
  - ServletContext
  - TemplateEnginesManager
  
and it can find what mode is Micro in: 
  
  - isDevelopment():boolean
  - isProduction():boolean
  - isTest():boolean




### <a id="microcontext"></a>MicroContext
class: `ca.simplegames.micro.MicroContext`

A MicroContext, known as: `context`, for short, is a class that will be instantiated for every Rack `call` and it becomes the common ground for sharing object references between all the objects participating in resolving that call. It gives access to the information received from Rack, and it is a convenient registry of objects available to every template at the rendering time. It is also a Map, allowing Controllers or the Views to pass objects from one to another. The `context` is abandoned immediately after the response was returned. 

The following objects are available in the context at any given time:
  - `site`