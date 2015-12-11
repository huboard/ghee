class Ghee
  class ApiTranslator
    attr_accessor :context

    def initialize(context)
      @context = context
    end

    def translate_data(data)
      raise NotImplemented
    end
  end
end
