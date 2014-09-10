module ProductParser
  class CategoryPage
    attr_accessor :document, :host_url
    attr_accessor :links, :pages, :products

    def initialize(document, host_url = nil)
      @document = document
      @host_url = host_url

      @pages = []
      @products = []
    end
    
    def build_products
      build_pages

      pages.each do |page|
        products.concat(page.products)
      end
    end
    
    def build_pages
      obtain_links
      absolutize_links
      
      links.each do |link|
        pages << ProductPage.new(Document.from_url(link.to_s))
      end
    end
    
    def obtain_links
      @links = document.search_elements(
        "//div[@class='floating-content-box']" +
        "//a[@class='product-content-box panel']/@href")
    end

    def absolutize_links
      @links = @links.map do |link|
        URI::join(host_url, link).to_s
      end if host_url
    end

    def to_csv(csv)
      build_pages

      pages.each { |page| page.to_csv(csv) }
    end
  end
end