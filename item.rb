require 'rubygems'
require 'bundler/setup'
require 'nokogiri'

require './item_test'

class Item
  attr_accessor :title, :price, :image_url, :delivery_at, :sku
  attr_accessor :doc, :base
  
  def initialize(doc, base = nil)
    @doc = doc
    @base = base || "/html/body/div[3]/div[4]/div/div"
  end
  
  def title
    search_element("//li[@itemprop='offers']//*[@itemprop='name']").content.gsub("\n", " ").strip
  end
  
  def price
    search_element("//span[@itemprop='price']").content
  end
  
  def image_url
    search_element("//div[@class='gridbox one-quarter']/img[1]/@src").value
  end
  
  def delivery_at
    search_element("//li[@itemprop='offers']//strong[contains(@class, 'stock')]/text()").content.strip
  end
  
  def sku
    search_element("//li[@itemprop='offers']//*[@itemprop='sku']").content
  end
  
  private
  
    def search_element(selector)
      found = doc.xpath(base + selector)
      raise 'Found more than one element' if found.length > 1
      raise 'Found no such element' if found.empty?
      
      found.first
    end
end