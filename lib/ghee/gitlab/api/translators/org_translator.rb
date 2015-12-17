class Ghee
  module GitLab
    class OrgTranslator < Ghee::ApiTranslator
      def translate_hash(data)
        new_user = {}
        new_user['login'] = data['path']
        new_user['id'] = data['id']
        new_user['description'] = data['description']

        new_user
      end
    end
  end
end
