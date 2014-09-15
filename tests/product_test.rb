require '../product_parser'
require 'minitest/autorun'

module ProductParser
  describe Product do
    before do
      @document = Document.from_content(File.read('./data/single_product_page.html'))
      @document = Document.from_xml_element(@document.search_element("//*[@id='product_listing']"))
    end
  
    it 'should have a title' do
      product = Product.new(@document)
    
      assert_equal 'Hills Prescription Diet AD Dog & Cat Food » ' +
                   'Liver & Chicken Wet » 24 x 156g Cans',
                   product.attribute(:title)
    end
  
    it 'should have a price' do
      product = Product.new(@document)
    
      assert_equal '£41.27', product.attribute(:price)
    end
  
    it 'should have an image url' do
      product = Product.new(@document)
    
      assert_equal 'http://static1.viovet.co.uk/pi/created_1350058007.png',
                    product.attribute(:image_url)
    end
  
    it 'should have delivery time' do
      product = Product.new(@document)
    
      assert_equal 'Estimated dispatch within 24 working hours',
                    product.attribute(:delivery_at)
    end
  
    it 'should have sku' do
      product = Product.new(@document)
    
      assert_equal '110368', product.attribute(:sku)
    end
  end
end