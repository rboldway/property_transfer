require "property_transfer/version"
require "property_transfer/pattern_action_registry"

require 'forwardable'

module PropertyTransfer

  class RecordTransfer
    extend Forwardable

    attr_accessor :input, :document, :city
    def_delegators :@pattern_matcher, :register, :upon_match

    Properties = {}

    def initialize(document, pattern_matcher = PatternActionRegistry.new)
      @document = document
      @pattern_matcher = pattern_matcher
      @last_line = nil
    end

    def run
      register(/^([0-9A-Za-z ]+)[,:; ]+\$([0-9,]+)$/, :property)
      register(/^([A-Z a-z-]{2,})$/,:city)

      # loop thru lines sequentiallly
      document.each_line do |line|
        perform(upon_match(line))
      end
    end

    def seek_content(pattern)
      @document.each_line.detect { |line| %r{#{pattern}}.match(line) }
    end

    private

    def perform(hash)
      action = hash.keys.first
      public_send(action,hash[action])
    end

    def city(content)
      @city ||= content.to_s.strip.squeeze(" ")
    end

    def property(content)
      property = content.to_a.drop(1)
      price = property.pop
      property[0].squeeze(" ")
      property << @city << "WI" << price
      puts property.join(", ")
    end

  end

end


