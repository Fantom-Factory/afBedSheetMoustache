#BedSheet Moustache v1.0.12
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v1.0.12](http://img.shields.io/badge/pod-v1.0.12-yellow.svg)](http://www.fantomfactory.org/pods/afBedSheetMoustache)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

BedSheet Moustache is a simple Fantom library that integrates [Mustache](https://bitbucket.org/xored/mustache/) templates with the [BedSheet](http://pods.fantomfactory.org/pods/afBedSheet) web framework.

It provides a cache for your compiled [Mustache](https://bitbucket.org/xored/mustache/) templates and throws [MoustacheErr](http://pods.fantomfactory.org/pods/afBedSheetMoustache/api/MoustacheErr)s to show details of compilation failures.

## Install

Install `BedSheet Moustache` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afBedSheetMoustache

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afBedSheetMoustache 1.0"]

## Documentation

Full API & fandocs are available on the [Fantom Pod Repository](http://pods.fantomfactory.org/pods/afBedSheetMoustache/).

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

## Template Errors

Mustache template errors are pretty printed with a snippet of the source code in error:

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

Sections are also added to the standard [BedSheet](http://pods.fantomfactory.org/pods/afBedSheet) Err page to show the same.

![Moustache Err in BedSheet](moustacheErr.png)

