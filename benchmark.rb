require 'benchmark'
require './product_page'

doc = Nokogiri::HTML(File.read('./test_data/single_product_page.html'))

Benchmark.bm do |x|
  x.report('base path is very specific') {
    product_page = ProductPage.new(doc, '/html/body/div[3]/div[4]/div/div')
    product_page.build_products

    1000.times do
      product_page.products.first.title
      product_page.products.first.price
      product_page.products.first.image_url
      product_page.products.first.delivery_at
      product_page.products.first.sku
    end
  }
  
  x.report('base path is not so much specific') {
    product_page = ProductPage.new(doc, '/')
    product_page.build_products
    
    1000.times do
      product_page.products.first.title
      product_page.products.first.price
      product_page.products.first.image_url
      product_page.products.first.delivery_at
      product_page.products.first.sku
    end
  }
end
