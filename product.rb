require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

class Product
  attr_accessor :title, :price, :image_url, :delivery_at, :sku
  attr_accessor :base_node
  
  def initialize(base_node)
    @base_node = base_node
  end
  
  def title
    search_element(".//*[@itemprop='name']").content.gsub("\n", " ").strip
  end
  
  def price
    search_element(".//span[@itemprop='price']").content
  end
  
  def image_url
    search_element("//div[@class='gridbox one-quarter']/a[@class='fancybox-thumb']/img[1]/@src").value
  end
  
  def delivery_at
    search_element(".//strong[contains(@class, 'stock')]/text()").content.strip
  end
  
  def sku
    search_element(".//strong[@itemprop='sku']").content
  end
  
  def to_a
    [title, price, image_url, delivery_at, sku]
  end
  
  private
  
    def search_element(selector)
      found = base_node.xpath(selector)
      raise 'Found more than one element' if found.length > 1
      raise 'Found no such element' if found.empty?
      
      found.first
    end
end