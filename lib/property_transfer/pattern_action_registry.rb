module PropertyTransfer

  class PatternActionRegistry

    def initialize
      @registry = {}
    end

    def register(pattern, action)
      # TODO: require that pattern has named captures
      key = Regexp.new(pattern)
      @registry[key] = action
      {key =>  action}
    end

    def upon_match(line)
      matched = nil
      pattern = nil
      @registry.keys.detect do |pat|
        matched = pat.match(line)
        pattern = pat
      end
      matched.named_captures.merge({action: @registry[pattern]})
    end

  end

end
