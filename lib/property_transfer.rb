require "property_transfer/version"
require "property_transfer/pattern_action_registry"

require 'forwardable'

module PropertyTransfer

  class RecordTransfer
    extend Forwardable

    def initialize(input = $stdin, pattern_matcher = PatternActionRegistry.new)
      @input = input
      @pattern_matcher = pattern_matcher
      register( {/^(?<address>[0-9A-Za-z ]+)[,:; ]+\$(?<price>[0-9,]+)$/ => :property} )
      register( {/^(?<city>[A-Z a-z-]{2,})$/ => :city} )
      @property = {:state => "WI"}
    end

    def run
      seek_content(/\s*Property Purchase Price\s*/)
      while line = input.gets
        perform(upon_match(line.chomp))
      end
    end

   private

    attr_reader :input
    attr_accessor :property
    def_delegators :@pattern_matcher, :register, :upon_match

    def seek_content(pattern)
      while line = input.gets
        break if Regexp.new(pattern).match(line.chomp)
      end
    end

    def perform(matched)
      # TODO: great error checkpoint
      return unless matched
      property.keep_if {|k,_| [:state, :city].include? k }
      send("#{matched[:action]}=", property.merge!(matched))
    end

    def city=(matched)
      city = matched[:city].to_s.strip.squeeze(" ")
      property.merge!({:city => city})
    end

    def property=(matched)
      property.merge!(matched)
      property.delete(:action)
      puts property
    end

  end

end


