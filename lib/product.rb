module ProductParser
  class Product
    attr_accessor :document
    
    XPATHS = {
      title:       ".//*[@itemprop='name']",
      price:       ".//span[@itemprop='price']",
      image_url:   "//div[@class='gridbox one-quarter']/img[1]/@src | " + 
                   "//div[@class='gridbox one-quarter']/a/img[1]/@src",
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
        attribute(:title), 
        attribute(:price),
        attribute(:image_url),
        attribute(:delivery_at),
        attribute(:sku)
      ]
    end
    
    def attribute(name)
      modify_attribute_content(name, get_attribute_content(name))
    end
    
    private
    
      def modify_attribute_content(name, content)
        MODS[name].call(content)
      end
      
      def get_attribute_content(name)
        document.search_element(XPATHS[name]).content
      end
  end
end