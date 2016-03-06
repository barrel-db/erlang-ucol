# ucol_nif

Simple [collation](http://userguide.icu-project.org/collation) module
based on NIf that allows you to sort binaries.

## Requirements

This module requires [icu4c](http://site.icu-project.org/) installed on your
system.

> OSX users: the build use the version installed with your system.

## Example of usage

    1> ucol:compare(<<"foo">>, <<"bar">>).
    1
    2> ucol:compare(<<"foo">>, <<"foo">>).
    0
    3> ucol:compare(<<"A">>, <<"aai">>).
    -1

The function compare returns `1` when the initial binary is greater than
the other, `0` when they are equivalent or `-1` when the one is less than
the other.
