require 'minitest/autorun'

require './product'
require './product_page'

describe Product do
  before do
    page_doc = Nokogiri::HTML(File.read('./test_data/single_product_page.html'))
    @base_node = ProductPage.new(page_doc).products_nodes.first
  end
  
  it 'should have a title' do
    product = Product.new(@base_node)
    
    assert_equal 'Hills Prescription Diet AD Dog & Cat Food » ' +
                 'Liver & Chicken Wet » 24 x 156g Cans',
                 product.title
  end
  
  it 'should have a price' do
    product = Product.new(@base_node)
    
    assert_equal '£41.27', product.price
  end
  
  it 'should have an image url' do
    product = Product.new(@base_node)
    
    assert_equal '//static1.viovet.co.uk/pi/created_1350058007.png',
                  product.image_url
  end
  
  it 'should have delivery time' do
    product = Product.new(@base_node)
    
    assert_equal 'Estimated dispatch within 24 working hours.',
                  product.delivery_at
  end
  
  it 'should have sku' do
    product = Product.new(@base_node)
    
    assert_equal '110368', product.sku
  end
end