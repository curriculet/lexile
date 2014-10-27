# Lexile® 

This gem wraps a portion of the Lexile database API. You need to obtain an
authorized username and password from Lexile to use the API. This gem is not
meant to be a comprenhensive implementation of the API just a bare bones
"Find the Lexile for a Specific Book" solution.

The gem only covers the endpoints to the `book` resource, the `category` and
`serial` resources are beyond the scope of this gem . If you need access
 to these resources feel free to submit a PR with code and specs.

The gem does not support pagination for result-sets longer than 20 books, while
the API contains all provisions for pagination, it is beyond the scope of the
gem to expose those.

## Installation

Add this line to your application's Gemfile:

    gem 'lexile'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lexile

## Usage

    >>  b = Lexile.books.show("315833")
    #<Lexile::Book id= "315833" ISBN="006201272X" ISBN13="9780062012722" ... >

    >>  b.title
    "It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary"



    >> b = Lexile.books.find_by_isbn13("9780062012722")
    [#<Lexile::Book ISBN="006201272X" ISBN13="9780062012722" ... >]

    >>  b[0].title
    "It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary"



    >>  b = Lexile.books.find_by_title("to Nancy")
    [#<Lexile::Book ISBN="0380773155" ISBN13="9780380773152" ... >, #<Lexile::Book ISBN="006201272X" ISBN13="9780062012722" ... >]

    >> b.length
    2

    >>  b[0].title
    "It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary"


## Contributing

1. Fork it ( http://github.com/<my-github-username>/lexile/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes and specs(`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2014 Curriculet Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.