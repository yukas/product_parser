require '../product_parser'
require 'minitest/autorun'

module ProductParser
  describe CategoryPage do
    before do
      @document = Document.from_content(File.read('./data/category_page.html'))
    end

    it 'should parse all links out of category page' do
      page = CategoryPage.new(@document)
      page.obtain_links

      assert_equal 20, page.links.count
    end

    it 'should prefix links with site url' do
      page = CategoryPage.new(@document, 'http://www.viovet.co.uk/')
      page.obtain_links
      page.absolutize_links

      assert_equal true, page.links.first.include?('http://www.viovet.co.uk/')
    end
  end
end
