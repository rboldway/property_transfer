module PropertyTransfer

  class PatternActionRegistry

    def initialize
      @registry = {}
    end

    def register(pattern_action)
      @registry.merge!(pattern_action)
      @registry.slice(pattern_action.keys.first)
    end

    def upon_match(line)
      matched = nil
      pattern = nil
      @registry.keys.detect do |pat|
        matched = pat.match(line)
        pattern = pat
      end
      matched&.named_captures&.merge({action: @registry[pattern]})
    end

  end

end
