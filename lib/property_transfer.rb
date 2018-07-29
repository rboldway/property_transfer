require "property_transfer/version"

module PropertyTransfer


  class RecordTransfer

    attr_accessor :input, :document, :registry, :city

    def initialize(document)
      @document = document
      @registry = {}
      @last_line = nil
    end

    Properties = {}

    def register(pattern, action)
      registry[Regexp.new(pattern)] = action
    end

    def perform_upon_match(line)
      content = nil
      key = nil
      registry.keys.detect do |k|
        content = line.match(k)
        key = k
        content
      end
      send(registry[key], content) if content
      @last_line = content
    end

    def seek_content(pattern)
      @document.each_line.detect { |line| %r{#{pattern}}.match(line) }
    end

    def city(content)
      @city = content[1].to_s.chomp.squeeze(" ")
      # puts ":city #{@city}"
    end

    def property(property)
      property = property.to_a.drop(1)
      price = property.pop
      property[0].squeeze(" ")
      property << @city << "WI" << price
      puts property.join(", ")
    end

    def run
      register(/^([0-9A-Za-z ]+)[,:; ]+\$([0-9,]+)$/, :property)
      register(/^([A-Z a-z-]{2,})$/,:city)

      # loop thru lines sequentiallly
      document.each_line do |line|
        perform_upon_match(line)
      end
    end

  end

end


