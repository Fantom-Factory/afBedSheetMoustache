## Overview 

`BedSheet Moustache` is a Fantom library that integrates [Mustache](https://bitbucket.org/xored/mustache/) templates with the [BedSheet](http://www.fantomfactory.org/pods/afBedSheet) web framework.

It provides a cache for your compiled [Mustache](https://bitbucket.org/xored/mustache/) templates and throws [MoustacheErr](http://repo.status302.com/doc/afBedSheetMoustache/MoustacheErr.html)s to show details of compilation failures.

Example:

```
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
```

Sections are added to the standard [BedSheet](http://www.fantomfactory.org/pods/afBedSheet) Err page to show the same.

![Moustache Err in BedSheet](http://static.alienfactory.co.uk/fantom-docs/moustacheErr.png)

## Install 

Install `BedSheet Moustache` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afBedSheetMoustache

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afBedSheetMoustache 1.0+"]

## Documentation 

Full API & fandocs are available on the [Status302 repository](http://repo.status302.com/doc/afBedSheetMoustache/).

## Quick Start 

```
using afIoc::Inject
using afBedSheet::Text
using afBedSheetMoustache::MoustacheTemplates

const class RouteHandler {

  @Inject
  private const MoustacheTemplates templates

  new make(|This|in) { in(this) }

  Text renderPage() {
    html := templates.renderFromFile(`res/index.moustache`.toFile)
    return Text.fromHtml(html)
  }
}
```

