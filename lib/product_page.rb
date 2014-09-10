module ProductParser
  class ProductPage
    attr_accessor :document
    attr_accessor :products
    attr_accessor :nodes

    def initialize(document)
      @document = document

      @products = []
    end
    
    def build_products
      obtain_product_nodes

      nodes.each do |node|
        @products << Product.new(Document.from_xml_element(node))
      end
    end
    
    def obtain_product_nodes
      @nodes = document.search_elements("//ul[@id='product_listing']/li[@itemprop='offers']")
    end

    def to_csv(csv)
      build_products
      
      products.each do |product|
        product.to_csv(csv)
      end
    end
  end
end