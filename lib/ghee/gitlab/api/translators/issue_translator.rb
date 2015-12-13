class Ghee
  module GitLab
    class IssueTranslator < Ghee::ApiTranslator
      def translate_hash(input)
        case context
          when :extract_labels
            label_translator = LabelsTranslator.new(:labels)
            output = label_translator.translate_hash(input['labels'])
          else
            output = {}
            store_passthrough(input, output)
            store_remapped(input, output)
        end

        output
      end

      def store_passthrough(input, output)
        attributes = %w(id title state assignee state updated_at created_at milestone)
        attributes.each do |attr|
          output[attr] = input[attr]
        end
      end

      def store_remapped(input, output)
        output['id'] = input['iid']
        output['user'] = {}
        output['user']['id'] = input['author']['id']
        output['user']['login'] = input['author']['username']

        output['milestone'] = nil

        if input['milestone']
          translator = MilestoneTranslator.new(:milestone)
          output['milestone'] = translator.translate_hash(input['milestone'])
        end

        output
      end
    end
  end
end
