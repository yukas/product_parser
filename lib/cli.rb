module ProductParser
  class CLI
    def run
      url, filename = *ARGV
      
      document = Document.from_url(url)
      category_page = CategoryPage.new(document, 'http://www.viovet.co.uk/')
      
      CSV.open(filename, 'a') do |csv|
        category_page.to_csv(csv)
      end
    end
  end
end