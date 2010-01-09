Web App Theme
=============

Web App Theme is a rails generator by [Andrea Franz](http://gravityblast.com) that you can use to generate admin panels quickly.
Inspired by cool themes like [Lighthouse](http://lighthouseapp.com/), [Basecamp](http://basecamphq.com/), [RadiantCMS](http://radiantcms.org/) and others,
it wants to be an idea to start developing a complete web application layout.

Installation
------------

Install the gem with:

    sudo gem install web-app-theme -s http://gemcutter.org
  
You can also install it as a rails plugin:

    script/plugin install git://github.com/pilu/web-app-theme.git

Usage
-----

### Theme Generator

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

### Themed Generator

Start creating your controllers manually or with a scaffold, and then use the `themed generator` to overwrite the previously generated views.

If you have a controller named like the plural of the used model you can specify just the first parameter:

    script/generate themed posts # you have a model named Post and a controller named PostsController
    
    script/generate themed admin/gallery_pictures # you have a model named GalleryPicture and a controller named Admin::GalleryPicturesController

Use the `--layout` option specifying the previously generated layout to add a link to the controller you are working on:

    script/generate themed posts --layout=admin # you will see the `Posts` link in the navigation

If the controller has a name different to the model used, specify the controller path in the first parameter and the model name in the second one:

    script/generate themed items post
    
    script/generate themed admin/items post

If you use `will_paginate` for pagination use the `--with_will_paginate`:

    script/generate themed items post --with_will_paginate        

If you have something like `map.resource :dashboard` in your `routes.rb` file, you can use the `--type=text` to generate a view with just text:
    
    script/generate themed homes --type=text

If you want to show form error messages inside the generated forms, use the following code inside your `environment.rb`

    ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
      if html_tag =~ /<label/
        %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|
      else
        html_tag
      end
    end

If you want to have translated pages, simple create in your locale.yml the keys just like config/locales/en_us.yml example.
	en_us:
	  web-app-theme: 
	    save: Save
	    cancel: Cancel
	    list: List
	    edit: Edit
	    new: New
	    show: Show
	    delete: Delete
	    confirm: Are you sure?
	    created_at: Created at
	    all: All


![Web App Theme screenshot](http://img.skitch.com/20091109-c2k618qerx1ysw5ytxsighuf3f.jpg)

Contributing
---

* Fork this repository.
* Duplicate the  'themes/default' folder and rename it.
* Modify the style.css file adding your favorite colors.
* Add a link to your theme in the 'Switch Theme' block inside the index.html file.
* Send a pull request.

Links
-----

* Repository: git://github.com/pilu/web-app-theme.git
* List: <http://groups.google.com/group/web-app-theme-generator>
* Issues: <http://github.com/pilu/web-app-theme/issues>
* Gem: <http://gemcutter.org/gems/web-app-theme>
* Themes: <http://pilu.github.com/web-app-theme>

Author
------

Andrea Franz - [http://gravityblast.com](http://gravityblast.com)

Contributors
------------

* Nelson Fernandez
* Giovanni Intini
* Jeremy Durham
* Wouter de Vries
* Marco Borromeo
* rick mckay
* Peter Sarnacki
* Garret Alfert
* Mikkel Hoegh
* Juan Maria Martinez Arce
* Stas SUSHKOV
* Daniel Cukier
* Roberto Klein
* Bryan Woods
* Sandro Duarte

Credits
-------

* Icons: FAMFAMFAM Silk icons <http://www.famfamfam.com/lab/icons/silk/>
* Buttons: Particletree - Rediscovering the Button Element <http://particletree.com/features/rediscovering-the-button-element/>