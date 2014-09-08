require 'benchmark'
require './item'

doc = Nokogiri::HTML(File.read('./test_data/item.html'))

Benchmark.bm do |x|
  x.report('base path is very specific') {
    item = Item.new(doc, '/html/body/div[3]/div[4]/div/div')
    
    1000.times do
      item.title
      item.price
      item.image_url
      item.delivery_at
      item.sku
    end
  }
  
  x.report('base path is not so much specific') {
    item = Item.new(doc, '/')
    
    1000.times do
      item.title
      item.price
      item.image_url
      item.delivery_at
      item.sku
    end
  }
end
