module ProductParser
  class Document
    attr_accessor :nokogiri_document, :url
    
    def initialize(nokogiri_document, url = nil)
      @nokogiri_document = nokogiri_document
      @url = url
    end
    
    def search_element(xpath)
      found = search_elements(xpath)
      raise FoundMoreThanOneElement.new(xpath, url) if found.length > 1
      raise NoElementsFound.new(xpath, url) if found.empty?

      found.first
    end

    def search_elements(xpath)
      nokogiri_document.xpath(xpath)
    end
    
    def self.from_xml_element(element)
      new(element)
    end
    
    def self.from_url(url)
      begin
        from_content(Curl.get(url).body_str, url)
      rescue Curl::Err::HostResolutionError
        puts "Can't resolve the host"

        exit
      end
    end
    
    def self.from_content(content, url = nil)
      new(Nokogiri::HTML(content), url)
    end
  end
  
  class DocumentError < StandardError
    def initialize(xpath, url)
      super("#{xpath} - #{url}")
    end
  end
  
  class FoundMoreThanOneElement < DocumentError; end
  class NoElementsFound < DocumentError; end
end