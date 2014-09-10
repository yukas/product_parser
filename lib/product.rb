module ProductParser
  class Product
    attr_accessor :document
    
    XPATHS = {
      title:       ".//*[@itemprop='name']",
      price:       ".//span[@itemprop='price']",
      image_url:   "//div[@class='gridbox one-quarter']/img[1]/@src | //div[@class='gridbox one-quarter']/a/img[1]/@src",
      delivery_at: ".//strong[contains(@class, 'stock')]/text()",
      sku:         ".//strong[@itemprop='sku']"
    }
    
    MODS = {
      title:       lambda { |e| e.gsub("\n", " ").strip },
      price:       lambda { |e| e },
      image_url:   lambda { |e| "http:#{e}" },
      delivery_at: lambda { |e| e.strip.chomp('.') },
      sku:         lambda { |e| e }
    }
        
    def initialize(document)
      @document = document
    end
    
    def to_csv(csv)
      csv << [
        get_attribute(:title), 
        get_attribute(:price),
        get_attribute(:image_url),
        get_attribute(:delivery_at),
        get_attribute(:sku)
      ]
    end
    
    def get_attribute(attribute)
      element = search_element(attribute)
      modify(attribute, element)
    end
    
    def modify(attribute, element)
      MODS[attribute].call(element.content)
    end
    

    private

      def search_element(name)
        document.search_element(XPATHS[name])
      end
  end
end