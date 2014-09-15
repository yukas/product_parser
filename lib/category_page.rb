module ProductParser
  class CategoryPage
    attr_accessor :document, :host_url, :product_pages

    def initialize(document, host_url = nil)
      @document = document
      @host_url = host_url

      @product_pages = []
    end
    
    def to_csv(csv)
      build_product_pages

      product_pages.each { |product_page| product_page.to_csv(csv) }
    end
    
    def build_product_pages
      links = absolutize_links(obtain_product_page_links)
      
      links.each do |link|
        product_pages << ProductPage.new(Document.from_url(link.to_s))
      end
    end
    
    def obtain_product_page_links
      document.search_elements(
        "//div[@class='floating-content-box']" +
        "//a[@class='product-content-box panel']/@href")
    end
    
    private

      def absolutize_links(links)
        if host_url
          links.map { |link| URI::join(host_url, link).to_s } 
        else
          links
        end
      end
  end
end