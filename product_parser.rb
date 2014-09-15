require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'csv'
require 'curb'

$:.unshift(File.expand_path(File.dirname(__FILE__)))

module ProductParser
  autoload :CategoryPage, 'lib/category_page'
  autoload :ProductPage,  'lib/product_page'
  autoload :Product,      'lib/product'
  autoload :Document,     'lib/document'
  autoload :CLI,          'lib/cli'
end