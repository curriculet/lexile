module Lexile
  class Book < Hashie::Mash
    include Lexile::Model

    api_path 'book'

    # Book Resource
    #
    # This is the resource you will likely be using most often.  This represents a book.
    #
    # Field                	Type     	Filter	Description
    # ISBN                 	string   	ALL	    International Standard Book Number
    # booktype		          string   	ALL	    Booktype, e.g. Fiction
    # lexile_code		        string   	n/a	    Lexile Code, e.g. GN (graphic novel)
    # series			          string   	ALL	    Book Series, if any
    # lexile_code_spanish	  string		n/a	    Lexile Code for Spanish Lexile measure if available
    # word_count		        integer		ALL	    Number of words contained in the book
    # keyword		            string		ALL	    List of keywords
    # serial			          integer		gt      Serial Number this Resource was last modified on
    # id			              integer		n/a	    ID
    # max_age	 	            integer		ALL	    Max age of book
    # call_number		        string		n/a	    Call Number
    # copyright		          string		n/a	    Copyright year
    # author			          string		ALL	    Book Author(s)
    # lexile			          integer		ALL	    Lexile Measure
    # categories_display	  string		n/a	    List of categories
    # timestamp		          datetime 	gt,gte	Date/time the book record was last modified
    # min_age		            integer		ALL	    Minimum age of book
    # pages			            integer		ALL	    Number of pages contained in the book
    # categories		        related		ALL	    List of URIs or individually nested resource data
    # publisher		          string		ALL	    Book publisher
    # language		          string		ALL	    Book's written language
    # ISBN13			          string		ALL	    13-digit ISBN
    # lexile_spanish		    integer		n/a	    Spanish Lexile Measure
    # word_count_spanish   	integer		n/a	    Number of words in Spanish version of book
    # summary		            string		n/a	    Summary of the book
    # title			            string		ALL	    Book Title
    # resource_uri		      string		n/a	    The resource url for accessing this resource directly
    #
  end
end
