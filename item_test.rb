require './item'
require 'minitest/autorun'

describe Item do
  before do
    @doc = Nokogiri::HTML(File.read('./test_data/item.html'))
  end
  
  it 'should have a title' do
    item = Item.new(@doc)
    
    assert_equal 'Hills Prescription Diet AD Dog & Cat Food » ' +
                 'Liver & Chicken Wet » 24 x 156g Cans',
                 item.title
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