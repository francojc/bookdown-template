
# bookdown-template

This is a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). Please see the page "Get Started" at https://bookdown.org/ for how to compile this example.

## Additions

I've added new functionality to the default `bookdown-demo` in this `bookdown-template`:

1. Support for glossaries

First you must initialize a glossary before a reference is created. Add this code chunk:

```r
initGlossary() # main by default
```

Wrap the following inline R code around a term and it will be added to the glossary with a link to the specified section where it appears.

```r
enterGlossary(term = "Reference example", definition = "This is a test reference as an example.", reference = "intro", glossary = "main")
```

By default the `glossary = ` parameter will be `main`. If you add another glossary grouping, you will specify that in this parameter and will need to include an output chunk in the `9998-glossary.Rmd` file.

2. Support for taxonomies (specifically `tags` and `projects`)

Taxonomies allow for 'tagging'. The taxonomy sets 'tags' and 'projects' are included in this set up and are formatted as blocks (i.e. they are not rendered in-line).

As with glossaries, taxonomies must be initializd before use. 

```r
initTaxonomy(type = "tags")
```

Then a particular tag can be included with the following code inside an inline R chunk.

```r
enterTaxonomy(name = "tag", reference = "intro", type = "tags", description = "")
```

A `description = ""` parameter is option. If you do use the description, it only needs to be specified once. After that, all taxonomies with the same `name` parameter will contain the same description. 

The `9997-taxonomies.Rmd` file is enabled to output a `tags` taxonomy set. If you initialize and use another taxonomy, you will need to include a separate code chunk to output this new set. You will also need to edit the `css/taxonomies.css` file to ensure that the formatting appears as desired.
