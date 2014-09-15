require 'tests/test_helper'

module ProductParser
  describe CategoryPage do
    before do
      @document = Document.from_content(File.read('tests/data/category_page.html'))
    end

    it 'should parse all links out of category page' do
      Document.stub :from_url, '' do
        category_page = CategoryPage.new(@document)
        category_page.build_product_pages

        assert_equal 20, category_page.product_pages.count
      end
    end
  end
end
