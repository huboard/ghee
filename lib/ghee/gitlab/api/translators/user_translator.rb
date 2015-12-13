class Ghee
  module GitLab
    class UserTranslator < Ghee::ApiTranslator
      def translate_hash(data)
        new_user = {}
        new_user['id'] = data['id']
        new_user['login'] = data['username']
        new_user['avatar_url'] = data['avatar_url']
        new_user['name'] = data['name']
        new_user['email'] = data['email'] if data['email']
        new_user
      end
    end
  end
end
