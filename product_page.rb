require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'csv'

require './product'

class ProductPage
  attr_accessor :doc, :base, :products
  
  def initialize(doc, base = nil)
    @doc = doc
    @base = base || '/html/body/div[3]/div[4]/div/div'
    @products = []
    
    build_products
  end
  
  def build_products
    products_nodes.each do |product_base|
      @products << Product.new(product_base)
    end
  end
  
  def products_nodes
    search_elements("//ul[@id='product_listing']/li[@itemprop='offers']")
  end
  
  def to_csv
    CSV.open('myfile.csv', 'a') do |csv|
      products.each do |product|
        csv << product.to_a
      end
    end
  end

  private
    def search_elements(selector)
      doc.xpath(base + selector)
    end
end


pp = ProductPage.new(Nokogiri::HTML(File.read('./test_data/multi_product_page.html')))
pp.to_csv