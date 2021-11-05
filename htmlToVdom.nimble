# Package

version       = "0.1.0"
author        = "C-NERD"
description   = "Karax extension to convert html in string form to embeddable Karax vdom"
license       = "MIT"
srcDir        = "src"
backend       = "js"


# Dependencies

requires "nim >= 1.0.0", "karax == 1.2.1"

task examples, "Compile all example files with karun":

    for file in listFiles("./examples"):

        exec "karun " & file