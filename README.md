Web App Theme
===

A simple layout by [Andrea Franz](http://gravityblast.com) that you can use in your web applications. 
Inspired by cool themes like [Lighthouse](http://lighthouseapp.com/), [Basecamp](http://basecamphq.com/), [RadiantCMS](http://radiantcms.org/) and others,
it wants to be an idea to start developing a complete web application layout.

Installation
---

Install the gem with:

    sudo gem install web-app-theme -s http://gemcutter.org
  
You can also install it as a rails plugin:

    script/plugin install git://github.com/pilu/web-app-theme.git

Usage
---

Theme Generator
--

Used without parameters, it generates the layout inside the application.html.erb file using the default theme.
  
    script/generate theme

You can specify the layout file name in the first parameter:

    script/generate theme admin # it will generate a layout called `admin.html.erb`

If you want to use another theme, instead of the default, you can use the `--theme` option:

    script/generate theme --theme="drastic-dark"


If you want to generate the stylesheets of a specific theme without changing the previously generated layout you can pass the `--no-layout` option:

    script/generate theme --theme=bec --no_layout


You can specify the text used in the header with the `--app-name` option:

    script/generate theme --app_name="My New Application"
  
If you need a layout for login and signup pages, you can use the `--type` option with `sign` as value. Ìf not specified, the default value is `administration`

    script/generate theme --type=sign

Themed Generator
--

script/generate themed posts

script/generate themed items Post

script/generate themed admin/items Post

script/generate themed admin/gallery_pictures

script/generate themed homes --type=text


Contributing
---


* Fork this repository.
* Duplicate the  'themes/default' folder and rename it.
* Modify the style.css file adding your favorite colors.
* Add a link to your theme in the 'Switch Theme' block inside the index.html file.
* Send a pull request.

![Web App Theme screenshot](http://gravityblast.com/wp-content/uploads/2009/01/web-app-theme-current.jpg)

Contributors
---

Nelson Fernandez ('Bec' theme and refactoring)