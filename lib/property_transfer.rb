require "property_transfer/version"
require "property_transfer/pattern_action_registry"

require 'forwardable'

module PropertyTransfer

  class RecordTransfer
    extend Forwardable

    def initialize(errors_only = false, pattern_matcher = PatternActionRegistry.new)
      @errors_only = errors_only
      @pattern_matcher = pattern_matcher
      register( {/^(?<address>[0-9A-Za-z,-\. ]+)[:; ]+\$(?<price>[0-9,]+)$/ => :property} )
      register( {/^(?<city>[A-Z a-z-]{2,})$/ => :city} )
      @property = {:state => "WI"}
    end

    def run
      seek = seek_content(/\s*Property Purchase Price\s*/)
      while line = ARGF.gets
        perform(line) unless line.chomp.empty?
      end
    end

   private

    attr_reader :input
    attr_accessor :property
    def_delegators :@pattern_matcher, :register, :upon_match

    def seek_content(pattern)
      exp = Regexp.new(pattern)
      while line = ARGF.gets
        break if exp.match(line.chomp)
      end
      line
    end

    def perform(line)
      matched = upon_match(line)
      property.keep_if {|k,_| [:state, :city].include? k }
      if matched
        send("#{matched[:action]}=", property.merge!(matched))
      else
        puts property.merge!( {:error => line} )
      end
    end

    def city=(matched)
      city = matched[:city].to_s.strip.squeeze(" ")
      property.merge!({:city => city})
    end

    def property=(matched)
      property.merge!(matched)
      property.delete(:action)
      puts property unless @errors_only
    end

  end

end


