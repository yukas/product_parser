require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'minitest/autorun'

class Item
  attr_accessor :doc
  attr_accessor :title, :price, :image_url, :delivery_at, :sku
  
  def initialize(doc)
    @doc = doc
  end
  
  def title
    search_element('h1[itemprop="name"]').content
  end
  
  def price
    search_element('.ours > span:nth-child(1)').content
  end
  
  def image_url
    search_element(
      'div.internal-row:nth-child(2) > ' + 
      'div:nth-child(1) > img:nth-child(1)')['src']
  end
  
  def delivery_at
    search_element('.stock').content.strip
  end
  
  def sku
    search_element('.item-code > strong:nth-child(2)').content
  end
  
  def inspect
    [title, price, image_url, delivery_at, sku].inspect
  end
  
  private
  
    def search_element(selector)
      found = doc.css(selector)
      raise 'Found more than one element' if found.length > 1
      raise 'Found no such element' if found.empty?
      
      found.first
    end
end

describe Item do
  before do
    @doc = Nokogiri::HTML(File.read('./item.html'))
  end
  
  it 'should have a title' do
    item = Item.new(@doc)
    
    assert_equal 'Hills Prescription Diet AD Dog & Cat Food', item.title
  end
  
  it 'should have a price' do
    item = Item.new(@doc)
    
    assert_equal '£41.27', item.price
  end
  
  it 'should have an image url' do
    item = Item.new(@doc)
    
    assert_equal '//static1.viovet.co.uk/pi/created_1350058007.png',
                  item.image_url
  end
  
  it 'should have delivery time' do
    item = Item.new(@doc)
    
    assert_equal 'Estimated dispatch within 24 working hours.',
                  item.delivery_at
  end
  
  it 'should have sku' do
    item = Item.new(@doc)
    
    assert_equal '110368', item.sku
  end
end