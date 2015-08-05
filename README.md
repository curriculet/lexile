[![Build Status](https://travis-ci.org/curriculet/lexile.svg?branch=master)](https://travis-ci.org/Curriculet/Lexile) 
[![Code Climate](https://codeclimate.com/github/curriculet/lexile/badges/gpa.svg)](https://codeclimate.com/github/curriculet/lexile)
[![Test Coverage](https://codeclimate.com/github/curriculet/lexile/badges/coverage.svg)](https://codeclimate.com/github/curriculet/lexile)
[![Gem Version](https://badge.fury.io/rb/lexile.svg)](http://badge.fury.io/rb/lexile)

# Lexile® 

This gem wraps a portion of the Lexile database API. You need to obtain an
authorized username and password from Lexile to use the API. This gem is not
meant to be a comprenhensive implementation of the API just a bare bones
"Find the Lexile for a Specific Book or Update your Lexile DB" solution.

The gem only covers the endpoint to the `book` resource, the `category` and
`serial` resources are beyond the scope of this gem . If you need access
 to these resources feel free to submit a PR with code and specs.

The gem now supports pagination for long result-sets using the `next` and `previous` links
of the `meta` element of the response. Pagination is implemented as an Enumerable and it is
transparent when you traverse the enumerable with each, select, map, etc.... ( `count` will
paginate the whole collection, a more efficient implementation using the `total_count` from 
the `meta` is left as practice for the reader)


## Installation

Add this line to your application's Gemfile:

    gem 'lexile'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lexile

## Configuration
    Lexile.configure do |c|
      c.username    = <YOUR USERNAME>
      c.password    = <YOUR PASSWORD>
    end

## Usage
```
    # FIND BY LEXILE ID
    >>  b = Lexile.books.show("315833")
    #<Lexile::Book id= "315833" ISBN="006201272X" ISBN13="9780062012722" ... >

    >>  b.title
    "It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary"


    # FIND BY ISBN13
    >> b = Lexile.books.find_by_isbn13("9780062012722").first
    [#<Lexile::Book ISBN="006201272X" ISBN13="9780062012722" ... >]

    >>  b[0].title
    "It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary"


    # FIND BY TITLE
    >>  books = Lexile.books.find_by_title("to Nancy")
    books.count
    >> 2
    
    books.each do |b|
        puts b.ISBN13
    end
    >>  9780380773152
    >>  9780062012722
  
    >>  books.first.title
    "It Happened to Nancy: By An Anonymous Teenager: A True Story from Her Diary"

    # GET LATEST UPDATES TO DB ( supports paging )
    books = Lexile.books.find( timestamp__gte: '2015-08-04', limit:100 )
    # will load pages of 100 elements at a time until there are no further pages
    books.each do |b|
            ....
    end
    
    books.first
    >>[#<Lexile::Book ISBN="006201272X" ISBN13="9780062012722" ... >]
    
    books.fist(20).last
    >>[#<Lexile::Book ISBN="00620XXX" ISBN13="9780063013733" ... >]
    
    books.count
    >>107  #will paginate through the whole collection
```        

## Contributing

1. Fork it ( http://github.com/curriculet/lexile/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes and specs(`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2015 Curriculet Inc

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
