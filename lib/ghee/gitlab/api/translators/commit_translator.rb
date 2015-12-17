class Ghee
  module GitLab
    class CommitTranslator < Ghee::ApiTranslator
      def translate_hash(input)
        output = {}
        output['sha'] = input['id']
        output['tree'] = { sha: input['id'] }
        output['commit'] = {}
        output['commit'] = { message: input['title'] }
        output['commit']['author'] = { email: input['author_email'],
                                       name: input['author_name'] }
        output
      end
    end
  end
end
