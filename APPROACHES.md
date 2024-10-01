# Approaches

### full-text SQL search on recipe name, ingredients

downside: performance
downside: inaccurate results - a search for a misspelled ingredient "egs" will return "chicken legs"
downside: no way to search for alternative names, e.g. courgette instead of zucchini

upside: easy to implement
upside: could use Elasticsearch / `pg_search` or something similar to improve performance

### extract ingredients using a regex

extract `3 cups flour` to `3` `cups` `flour`

`match /(\d+)\s*(\w+)\s*(\w+)/`

* downside: doesn't handle plurals
* downside: doesn't handle "a dash of"
* downside: doesn't handle "salt and pepper to taste"
* downside: extra work to get it right

* upside: performance
* upside: easier to implement searching for alternative names
