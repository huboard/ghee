class Ghee
  class ApiTranslator
    attr_accessor :context

    def initialize(context)
      @context = context
    end

    def translate_data(data)
      if data.class == Array
        data.map{ |input| translate_hash(input) }
      else
        translate_hash(data)
      end
    end

    def translate_hash(input)
      raise NotImplemented
    end
  end
end
