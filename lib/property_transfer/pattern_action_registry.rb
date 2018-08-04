module PropertyTransfer

  class PatternActionRegistry

    def initialize
      @registry = {}
    end

    def register(pattern, action)
      key = Regexp.new(pattern)
      @registry[key] = action
      {key =>  action}
    end

    def upon_match(line)
      content = nil
      key = nil
      @registry.keys.detect do |k|
        content = k.match(line).to_a.at(1)
        key = k
      end
      content ? {@registry[key] => content} : nil
    end

  end

end
