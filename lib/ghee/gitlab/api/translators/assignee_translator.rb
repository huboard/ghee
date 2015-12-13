class Ghee
  module GitLab
    class AssigneeTranslator < Ghee::ApiTranslator
      GUEST     = 10
      REPORTER  = 20
      DEVELOPER = 30
      MASTER    = 40
      OWNER     = 50

      def translate_hash(data)
        new_user = {}
        new_user['id'] = data['id']
        new_user['login'] = data['username']
        new_user['avatar_url'] = data['avatar_url']
        new_user['type'] = 'user'
        new_user['site_admin'] = data['access_level'].to_i > DEVELOPER
        new_user
      end
    end
  end
end
