## Micro for Designers

In this part we will talk about the things that matter the most to you. And we'll briefly touch the important ones.

 1. [Static content](#static)
    - public resources
 2. [Dynamic content](#dynamic) *(without Controllers)*
    - templates
    - code fragments
    - template languages
    - localization
 3. [Deployment](#deployment) *(during the design phase)*
    - local
    - cloud
 
First let's quickly create a test web application. Presuming you are in a folder where you can play with files and directories: `temp`, in your home directory. This will be here: `~/temp`. Let's create the app:

    $ cd ~/temp
    $ micro new demo
    # cd demo

We'll display the layout of the new app, specifying just the folders of interest for this document. The new `demo` app folder layout would look like this:
    
    demo/
    ├── images
    ├── js
    ├── styles
    │    └── main.css
    ├── WEB-INF
    │   ├── config
    │   │   ├── locales
    │   │   │   ├── messages_en.properties
    │   │   │   └── messages_fr.properties
    │   │   ├── micro-config.yml
    │   │   └── routes.yml
    │   ├── views
    │   │   ├── content
    │   │   │   └── index.html
    │   │   ├── partials
    │   │   │   └── footer.html
    │   │   └── templates
    │   │       ├── 404.html
    │   │       ├── 500.html
    │   │       └── default.html
    │   └── web.xml
    └── favicon.ico
      
### 1. Static content <name id="static">
This part is easy. Everything that is **outside** `WEB-INF` folder is public and served `as is`, hence: `static`, from Micro's perspective. In the layout above, these folders and files are public:

    demo/
    ├── images
    ├── js
    ├── styles
    │    └── main.css
    └── favicon.ico

Obviously you can have static content inside the `WEB-INF` folder, such as: plain text files or simple html fragments. The difference being that for these files Micro will check first if their content has to be processed through various [Template engines](/views/engines/md) and rendered before sending it out, but not before trying to check if there are business logic components (implemented as [Controllers](/controllers.md/), *etc.*) preventing the access to those resources; authentication, format and/or time-based restrictions, etc.

### 2. Dynamic content <name id="dynamic">
The dynamic content is stored in folders that Micro considers as: [Repositories](/repositories.md/). By convention, all these folders are tucked inside the `WEB-INF` folder, and there are many good reasons for this layout, we won't annoy you with these details. Out of the box, Micro is offering the layout above but you can change it as you wish, provided you're updating the `config/micro-config.yml` file and define them accordingly. For the `demo` application, our repositories are defined like this:

    repositories:
      content:   {path: views/content, cache: views, default: true}
      partials:  {path: views/partials, cache: views}
      templates: {path: views/templates, cache: views}
    
<name id="foot_1_back"/>Where: `content`, `partials` and `templates` are friendly names for these folders: `views/content`, `views/partials` and `views/templates`. You will use these friendly names to mix various html page fragments in order to **pull** them into your main templates, or other views. For example, if I have a view, say the *Registration* page, and I want to **reuse** the *Login* dialog, then in the `content/registration.html` page, I could have the following template code**<sup>[(1)](#foot_1)</sup>**:

    $partials.get("login_dialog.html")

And to show you a neat trick, if for example you have a "terms & conditions" page you want to display in the registration page and those T&Cs were written in [Markdown](/views/engines.md#Markdown) then you could include that page and render it to html **on the fly**, just like this:

    $partials.get("markdown", "registration_t_and_c.md")

The user will get back a nice and a consistent single html page that in the background was aggregated by Micro from various repositories, and using various template languages or viewers in the same time. Neat, eh? We hope so. Micro was designed to allow the Designers to become **Content Alchemists** :)
  
At the rendering time, after the business logic was evaluated, your `registration.html` page from the `views/content` folder, will **pull** the `login_dialog.html` from the `views/partials` folder and will result into a complete functional Registration dialog page. While this is happening Micro will take care of caching the most frequent used content so you will not disappoint your users. 

<span class="label label-important">Heads up!</span> 

Sometimes it is difficult to spot the rendering errors, especially if you have multiple partials nested together. Use the: `$!{error}` object, to find more details about the error. You can use it in your 404 template, example:

    templates/404.html, excerpt:
    ----------------------------
    
    <div class="container">
      <div class="row">
        <div class="span9 offset1">
          <h1>404</h1>
          <h3>
            Error in path: $!{path}
          </h3>
          <p class="text-muted">
            $!{error}
          </p>
        </div>
      </div>  
    </div>
  


A bit about localization. You most probably want to localize your web pages and if so then you will want to check the [Internationalization](internationalization.md) topic. Here's the gist of it:

  - translate your text and store it as `label=translated text` in the `message_<lng>.properties` files, where the `<lng>` stands for language; `en` for English, `de` for German, and so on; see the [Language localization](http://en.wikipedia.org/wiki/Language_localisation) for more details.
  - display translated text by wrapping the labels into some convenient macros provided by Micro for the pages using the Velocity template language. Example:

        `<h1>#i18N("hello_world")</h1>`

The snippet above will display: **`Hello world!`**, for English and: **`γειά σου κόσμος`**, for Greek; if the user selects different languages.

### 3. Deployment <name id="deployment">
Micro was designed to help you quickly prototype, that's why we wanted to make sure you can "start" your web application in server mode and begin designing your content right away. Unless you add new repositories or move them around, you don't have to restart the app in order to see your changes. Micro starts in `development` mode and there is no caching in this mode. To "start" the `demo` web application, simply run this command:

    $ micro start

And continue to work on your designs. To stop the server, press `CTRL-C` in the terminal were Micro is running, and the server stops. Micro's footprint is so small your laptop will thank you for such a small web development framework. It's a micro framework :)

Soon you have a layout and you would like to expose it to your client. With Micro you can quickly deploy your app into the cloud and start your Micro web application there. There is a page dedicated to this type of deployment and you can check it here: [Micro at Heroku](/micro_for/heroku.md/). More deployment examples will be added as this documentation evolves, stay tuned.

Have fun!

<hr>
*Notes:*

**<name id="foot_1"/><sup>[(1)](#foot_1_back)</sup> **- example using the [Velocity](/views/engines.md#Velocity) template language, but you can use [FreeMarker](/views/engines.md#Freemarker) as well, if you wish. Both template languages supported by Micro.
