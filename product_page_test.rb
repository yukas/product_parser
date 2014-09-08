require 'minitest/autorun'

require './product_page'

describe ProductPage do
  before do
    @multi_doc  = Nokogiri::HTML(File.read('./test_data/multi_product_page.html'))
    @single_doc = Nokogiri::HTML(File.read('./test_data/single_product_page.html'))
  end
  
  it 'should parse multiple products from multiple-product page' do
    @product_page = ProductPage.new(@multi_doc)
    
    assert_equal 2, @product_page.products.count
  end
  
  it 'should parse single product from single-product page' do
    @product_page = ProductPage.new(@single_doc)
    
    assert_equal 1, @product_page.products.count
  end
end