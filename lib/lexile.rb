require 'json'
require 'hashie/mash'
require 'httparty'

require 'lexile/configuration'
require 'lexile/version'
require 'lexile/api/client'
require 'lexile/errors'

# Data Models
require 'lexile/model'
require 'lexile/book'

#API Operations
require 'lexile/api/resource'
require 'lexile/api/books'
require 'lexile/api/endpoints'
require 'lexile/api/page'
require 'lexile/api/page_list'
require 'lexile/api/result_list'

module Lexile
  extend Configuration
  extend Api::Endpoints
end
