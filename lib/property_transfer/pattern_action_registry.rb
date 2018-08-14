module PropertyTransfer

  class PatternActionRegistry
    require 'symbolized'

    def initialize
      @registry = {}.to_symbolized_hash
    end

    def register(pattern_action)
      @registry.merge!(pattern_action)
      @registry.slice(pattern_action.keys.first)
    end

    def upon_match(line)
      matched = nil
      pattern = nil
      @registry.keys.detect do |pat|
        pattern = pat
        matched = pat.match(line)
        !matched.nil?
      end
      matched&.named_captures&.merge({action: @registry[pattern]}).to_symbolized_hash
    end

  end

end
