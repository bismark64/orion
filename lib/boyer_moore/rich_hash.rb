# Hash impersonator that accepts regular expressions as keys.  But the regular
# expression lookups are slow, so don't use them (unless you have to).
module Orion
  class RichHash
    def initialize
      @regexps = {}
      @regular = {}
    end

    def [](k)
      regular = @regular[k]
      return regular if regular
      if @regexps.size > 0
        @regexps.each do |regex,v| # linear search is going to be slow
          return v if regex.match(k) 
        end
      end
      nil
    end

    def []=(k,v)
      if k.kind_of?(Regexp)
        @regexps[k] = v
      else
        @regular[k] = v
      end
    end
  end
end