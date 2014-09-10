require '../product_parser'
require 'minitest/autorun'

module ProductParser
  describe Document do
    it 'should search for multiple elements' do
      document = Document.from_content(File.read('./data/category_page.html'))
      assert_equal 15, document.search_elements("//div[contains(@class, 'row')]").count
    end

    describe 'search for sigle element' do
      it 'should raise an error in case it found more than one element' do
        document = Document.from_content(File.read('./data/category_page.html'))

        proc {
          assert_equal 15, document.search_element("//div[contains(@class, 'row')]").count
        }.must_raise FoundMoreThanOneElement
      end

      it 'should raise an error in case no elements are found' do
        document = Document.from_content(File.read('./data/category_page.html'))

        proc {
          assert_equal 15, document.search_element("//div[@class='never-used']").count
        }.must_raise NoElementsFound
      end
    end
  end
end
