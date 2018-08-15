require "property_transfer/version"
require "property_transfer/pattern_action_registry"

require 'forwardable'

module PropertyTransfer

  class RecordTransfer
    extend Forwardable

    Properties = []

    def initialize(document, pattern_matcher = PatternActionRegistry.new)
      @document = document
      @pattern_matcher = pattern_matcher
      @last_line = nil
      register( {/^(?<address>[0-9A-Za-z ]+)[,:; ]+\$(?<price>[0-9,]+)$/ => :property} )
      register( {/^(?<city>[A-Z a-z-]{2,})$/ => :city} )
      @property = {:state => "WI"}
    end

    def run
      seek_content(/\s*Property Purchase Price\s*/)
      # loop thru lines sequentiallly
      document.each_line do |line|
        perform(upon_match(line))
      end
    end

   private

    attr_accessor :document, :city, :property
    def_delegators :@pattern_matcher, :register, :upon_match
    
    def seek_content(pattern)
      document.each_line.detect { |line| Regexp.new(pattern).match(line) }
    end

    private

    def perform(match_hash)
      action = match_hash[:action]
      public_send("#{match_hash[action]}=", match_hash)
    end

    def city=(match_hash)
      @city ||= match_hash[:city].to_s.strip.squeeze(" ")
    end

    def property=(match_hash)
      property = match_hash[:property]
      property[0].squeeze(" ")
      property << @city << "WI" << price
      puts property.join(", ")
    end

  end

end


