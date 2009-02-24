PixieDust
    by Jonathan Wilkins
    http://pixiedust.rubyforge.org

== DESCRIPTION:
A collection of little utility functions (many security related) for assorted
tasks in Ruby

Where applicable, they come with a standard version and a class mix in.
Ex:
NumberDust.nearest(value) is also available as Integer.pd_nearest

== FEATURES/PROBLEMS:
Features:
* Get random numbers in arbitrary ranges from OpenSSL (without skew due
  to modulo)

Problems:
* Need a good way to make sure that the OpenSSL library isn't using a
  broken PRNG

== SYNOPSIS:
require 'pixiedust'
x = RandomDust.between(10,20)

== REQUIREMENTS:
None yet.

== INSTALL:

* sudo gem install pixiedust

== LICENSE:

(The MIT License)

Copyright (c) 2008

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
