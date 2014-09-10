require '../product_parser'
require 'minitest/autorun'

module ProductParser
  describe ProductPage do
    before do
      @multi_doc  = Document.from_content(File.read('./data/multi_product_page.html'))
      @single_doc = Document.from_content(File.read('./data/single_product_page.html'))
    end
  
    it 'should parse multiple products from multiple-product page' do
      @product_page = ProductPage.new(@multi_doc)
      @product_page.build_products
    
      assert_equal 2, @product_page.products.count
    end
  
    it 'should parse single product from single-product page' do
      @product_page = ProductPage.new(@single_doc)
      @product_page.build_products
    
      assert_equal 1, @product_page.products.count
    end
  end
end