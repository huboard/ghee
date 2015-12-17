class Ghee
  module GitLab
    class LabelsTranslator < Ghee::ApiTranslator
      def translate_hash(input)
        output = []
        input.each do |label|
          output.push({'name' => label })
        end

        output
      end
    end
  end
end
