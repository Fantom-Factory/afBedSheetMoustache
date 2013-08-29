# afBedSheetMoustache

`afBedSheetMoustache` is a [Fantom](http://fantom.org) library that integrates [Mustache](https://bitbucket.org/xored/mustache/) templates with the
[afBedSheet](http://repo.status302.com/doc/afBedSheet/#overview) web framework.

`afBedSheetMoustache` provides a cache for your compiled [Mustache](https://bitbucket.org/xored/mustache/) templates and throws `MoustacheErr`s to show details of any compilation failures.

Example:

    Moustache Compilation Err:
      file:/C:/Projects/Fantom/BedSheetMoustache/test/app/compilationErr.moustache : Line 11
        - Unbalanced "{" in tag "{ alienHeadSvg }  <span class="brand">{{ title"

         6:         {{{ bedSheetCss }}}
         7:     </style>
         8: </head>
         9: <body>
        10:     <header>
    ==> 11:         {{{ alienHeadSvg }
        12:         <span class="brand">{{ title }}</span>
        13:     </header>
        14:
        15:     <main>
        16:         {{{ content }}}



## Quick Start

    using afIoc::Inject
    using afBedSheet::Text

    const class RouteHandler {

      @Inject 
      private const MoustacheTemplates templates

      new make(|This|in) { in(this) }

      Text renderPage() {
        html := templates.renderFromFile(`res/index.moustache`.toFile)
        return Text.fromHtml(html)
      }
    }



## Documentation

Full API & fandocs are available on the [status302 repository](http://repo.status302.com/doc/afBedSheetMoustache/#overview).



## Install

Download from [status302](http://repo.status302.com/browse/afBedSheetMoustache).

Or install via fanr:

    $ fanr install -r http://repo.status302.com/fanr/ afBedSheetMoustache

