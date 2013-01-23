## The Cache system

The caching system in Micro is an extremely important feature. Designed to be configured by the non-developer and to be tweaked in detail by the developer or DevOps.

Micro's default cache implements a wrapper around the [Ehache](http://ehcache.org/), but other implementations can be easily added by implementing the: `ca.simplegames.micro.cache.MicroCache` interface. In fact, Micro is distributed with the Ehcache, enabled by default, and with a very simple in-memory cache, the: `ca.simplegames.micro.cache.SimpleMapCache`. For production we recommend the former.

You have a great degree of flexibility deciding about the cache space properties such as: size, life-cycle, if it is distributed or not, disk persistence, ephemeral or eternal, etc. You can assign specific cache spaces to specific Micro components, or leave the Micro components without the cache. Complicated? No worries, it is not.

### Defining the cache
The cache is defined in the: `config/micro-config.yaml` file, example:
    
    cache:
      names: [cacheForTemplates, views, controllers, mySecretCache]
      class: ca.simplegames.micro.cache.DefaultCache

In the example above we're using the default Micro cache implementation (using Ehcache) and we're defining 4 distinct cache spaces: `cacheForTemplates`, `mySecretCache`, `views` and `controllers`. The plan, in the scenario above, is to allow Micro to dedicate some cache spaces to the repositories and use a dedicated cache for caching the controllers (especially the scripted controllers).

### Using the cache
It wasn't hard, right?! Good, now that we have the cache ready, let's use it. Example from the same file, the `config/micro-config.yaml`, respectively:

    repositories:
      content: {path: views/content, cache: views, config: config, default: true}
      partials: {path: views/partials, cache: views, config: config}
      templates: {path: views/templates, config: config, cache: cacheForTemplates}

    controllers: {path: controllers, cache: controllers}

Observe the `cache` key in all the configurations above. Indeed, for every repository or controller, you can specify which cache to be used. For example, the `content` and the `partials` repositories are sharing the `views` cache, while the `templates` is using the cache named: `cacheForTemplates`. Controllers will use their own dedicated cache, the one named: `controllers`. You can, of course, use just one cache space for all the components, if that suits your request.

But what about the `mySecretCache`? Hehe. You can create your own cache, or as many as your system can hold, a cache that will not be "contaminated" by Micro :) Then you can use it in your own controllers, views, extensions or anywhere you wish. 

You access a cache by its **name**. Example of using the cache in a Velocity template:

    #set($mySecretCache = $site.CacheManager.getCache("mySecretCache"))
    Displaying a value from my secret cache: ${mySecretCache.get("mySecret")}

or fancier:    

    Displaying a value from my secret cache: ${mySecretCache.mySecret}

### Advanced cache configuration
To understand how to configure the cache, some knowledge about Ehcache is required. And we recommend using the documentation of Ehcache, here is a link to their [Getting Started](http://ehcache.org/documentation/get-started) guide. 

Micro's default cache implementation is inheriting the Ehcache settings from a file named: `ehcache.xml`. If you don't want to touch it, then it is ok, we're already providing you a minimum configuration:

    
    <ehcache>
      <diskStore path="java.io.tmpdir"/>

      <defaultCache
          maxElementsInMemory="500"
          eternal="false"
          overflowToDisk="false"
          timeToIdleSeconds="10"
          timeToLiveSeconds="20"
          />
    </ehcache>
    
The `defaultCache` will be used as a parent configuration by all the cache spaces defined in Micro, unless you manually tweak the file above. Let's say you want a bigger space for Views. Copy the file above in your classpath, a good spot is: `WEB-INF/classes/ehcache.xml`. This will overwrite the settings offered by Micro. And edit the file as follows:

    WEB-INF/classes/ehcache.xml:
    ----------------------------
    
    <ehcache>
      <diskStore path="java.io.tmpdir"/>

      <defaultCache
          maxElementsInMemory="500"
          eternal="false"
          overflowToDisk="false"
          timeToIdleSeconds="10"
          timeToLiveSeconds="20"
          />
      
      <cache name="views"
           maxElementsInMemory="500"
           eternal="false"
           timeToIdleSeconds="320"
           timeToLiveSeconds="420"
           overflowToDisk="false"
           diskPersistent="false"
           diskExpiryThreadIntervalSeconds="60"
            />      
    </ehcache>
    

Observe the `name='views'`! Yes, when you define a cache name in the `micro-config.yml` file, Micro will try to find a cache with the same name defined in the `ehcache.xml` file. If it is found than Micro will create a new cache with the properties specified in the `ehcache.xml`, otherwise will use the `defaultCache` properties, from the same file. This way you can tweak the cache in any way permitted by Ehcache. Please check the Ehcache site for additional information about [Ehcache configuration](http://ehcache.org/documentation/configuration).




