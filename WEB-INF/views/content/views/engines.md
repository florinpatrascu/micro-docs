## Template engines
Micro provides a means for plugging in a variety of template engines. This flexible system allows Designers to use the view Template engine of choice and even mixing them in the same rendering process. Imagine having the power of Velocity and Freemarker for accessing objects while for simple stuff such as:  "Term and Conditions", "About us", "Contact", *etc.*, you could bring in the versatility of Markdown. All these are possible in Micro. 

By default Micro currently uses the Velocity template language as the default template engine. You can control the template engines by modifying the `micro-config.yml` file, excerpt:
    
    template_engines:
      - engine:
          name: velocity
          class: ca.simplegames.micro.viewers.velocity.VelocityViewRenderer
          options:
            resource_cache_enabled: true
            resource_cache_interval: 15
            global_macro_library: global_library.vm
          default: true

      - engine:
          name: markdown
          class: ca.simplegames.micro.viewers.markup.MarkupViewRenderer

      - engine:
          name: freemarker
          class: ca.simplegames.micro.viewers.freemarker.FreemarkerViewRenderer

All the engines above are provided out-of-the-box with Micro but you can implement your own template engine, if you wish. We will highly appreciate your contribution to this project and looking forward for your pull requests.

### <name id="Velocity">Velocity
The Velocity view renderer uses the [Velocity template engine](http://velocity.apache.org/engine/devel/index.html) from the Jakarta project.

Velocity provides a means for having global macros which are defined together in a single file and which can then be used throughout your application in the Velocity templates. Micro will look for this file and, if it is used, be called `global_library.vm` and should be placed in the `WEB-INF/classes` directory or in the `CLASSPATH`.  
  
If you want to learn more about Velocity you can visit the following links:
  
  - [APACHE Velocity](http://velocity.apache.org/engine/devel/index.html)
  - [Velocity User Guide](http://velocity.apache.org/engine/devel/user-guide.html)
  - [VTL Reference](http://velocity.apache.org/engine/devel/vtl-reference-guide.html)

or:  
  - the [Velocity developer guide](http://velocity.apache.org/engine/devel/developer-guide.html)
  
### <name id="Markdown">Markdown
### <name id="Freemarker">Freemarker