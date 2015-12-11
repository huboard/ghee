class Ghee
  module GitLab
    class MilestoneTranslator < Ghee::ApiTranslator
      def translate_hash(input)
        output = {}
        output['id'] = input['id']
        output['title'] = input['title']
        output['due_on'] = input['due_date']
        output['created_at'] = input['created_at']
        output['updated_at'] = input['updated_at']
        output
      end
    end
  end
end
