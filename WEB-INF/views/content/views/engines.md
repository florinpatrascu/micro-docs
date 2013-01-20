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

All the engines above are provided out-of-the-box with Micro but you can implement your own template engine, if you wish. We will highly appreciate your contribution to this project and looking forward for your pull requests.

### <name id="Velocity">Velocity
The Velocity view renderer uses the [Velocity template engine](http://velocity.apache.org/engine/devel/index.html) from the Jakarta project.
  
If you want to learn more about Velocity you can visit the following links:
  
  - [APACHE Velocity](http://velocity.apache.org/engine/devel/index.html)
  - [Velocity User Guide](http://velocity.apache.org/engine/devel/user-guide.html)
  - [VTL Reference](http://velocity.apache.org/engine/devel/vtl-reference-guide.html)

or:  
  - the [Velocity developer guide](http://velocity.apache.org/engine/devel/developer-guide.html)
  
### <name id="Markdown">Markdown
[Markdown](http://daringfireball.net/projects/markdown/) to quote the author, is:

> ... a text-to-HTML conversion tool for web writers. Markdown allows you to write using an easy-to-read, easy-to-write plain text format, then convert it to structurally valid XHTML (or HTML).

The Markdown implementation in Micro is a simple and efficient view renderer. Since this implementation is not allowing the interpolation of dynamic objects, Micro allows you to chain pre-processed Velocity or FreeMarker templates with pages using the Markdown syntax, obtaining an efficient method to merge complex content while using a minimal formatting syntax. 

To enable the Markdown support in Micro, add the following configuration in your `micro-config.yml` file:
    
    - engine:
        name: markdown
        class: ca.simplegames.micro.viewers.markup.MarkupViewRenderer

The Markdown implementation from Micro is based on two very nice libraries: [prgdown](https://github.com/sirthias/pegdown) and [parboiled](http://www.parboiled.org/). With `pegdown` the following extensions are supported over the standard Markdown:
<small>
  
 - SMARTS: Beautifies apostrophes, ellipses ("..." and ". . .") and dashes ("--" and "---")
 - QUOTES: Beautifies single quotes, double quotes and double angle quotes (« and »)
 - SMARTYPANTS: Convenience extension enabling both, SMARTS and QUOTES, at once.
 - ABBREVIATIONS: Abbreviations in the way of PHP Markdown Extra.
 - HARDWRAPS: Alternative handling of newlines, see Github-flavoured-Markdown
 - AUTOLINKS: Plain (undelimited) autolinks the way Github-flavoured-Markdown implements them.
 - TABLES: Tables similar to MultiMarkdown (which is in turn like the PHP Markdown Extra tables, but with colspan support).
 - DEFINITION LISTS: Definition lists in the way of PHP Markdown Extra.
 - FENCED CODE BLOCKS: Fenced Code Blocks in the way of PHP Markdown Extra or Github-flavoured-Markdown.
 - HTML BLOCK SUPPRESSION: Suppresses the output of HTML blocks.
 - INLINE HTML SUPPRESSION: Suppresses the output of inline HTML elements.
 - WIKILINKS: Support [[Wiki-style links]] with a customizable URL rendering logic.

*(content above was extracted from [source](https://github.com/sirthias/pegdown))*.
</small>

Learn more about Markdown:

 - [Basics](http://daringfireball.net/projects/markdown/basics)
 - [Syntax](http://daringfireball.net/projects/markdown/syntax)
  
### <name id="Freemarker">FreeMarker
[\<FreeMarker\>](http://freemarker.sourceforge.net/) engine provides a larger set of features when compared to Velocity and therefore may be a desirable alternative to Velocity.

To enable FreeMarker in a Micro application, add the following configuration in your `micro-config.yml` file:

    - engine:
        name: freemarker
        class: ca.simplegames.micro.viewers.freemarker.FreemarkerViewRenderer

Learn more about the FreeMarker engine:

 - [features](http://freemarker.sourceforge.net/features.html)
 - FreeMarker [Wiki](http://freemarker.org/wiki/homepage.action)
 
### Building Your Own
To build your own Template engine you must implement the `ca.simplegames.micro.viewers.ViewRenderer` interface. Take a look at the available implementations to have an idea about how it is done. Please send us a pull request, if you would like your implementation to be included in the Micro default distribution.

<span class="label label-important">Heads up!</span> 
    
    ViewRenderer implementations should strive to make use of caching mechanisms provided by their respective template engines or use the cache support form Micro. This will avoid unnecessary parsing.
