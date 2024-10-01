* set up rails
* add postgres + redis
* add bootstrap + bootstrap-forms
* add slim
* generate recipe scaffold
* create ingredients model
* add rubocop
* add pry, .pryrc
* add annotate
* add rspec
* add awesome_print
* add oj, and create initializer
* create db and run migrations
* create rake task to import recipes from json
* update db seeds to call rake task
* annotate models
* import recipes into DB
* create basic index page
* create form for searching recipes
* render search results
* rename recipe.image to recipe.image_url
* add some tests
* add some styling

TODO:

* search doesn't handle case-sensitivity yet
* add a simple feature that lets the users select common ingredients from a list without having to type them
* add an checkbox option to the form to require all the ingredients in the search results

NOTES:

* images don't work, need to strip out the reference to the CDN
* there's a bunch of boilerplate code that can be cleaned up
* `rake db:seed` calls a rake task that can be reused for importing recipes, e.g. other languages (French)
* I put a `DK:` in front of some things so it's easier to see what changes I made from default Rails