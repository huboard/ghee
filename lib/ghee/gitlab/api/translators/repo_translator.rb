class Ghee
  module GitLab
    class RepoTranslator < Ghee::ApiTranslator
      def translate_data(input)
        if input.class == Array
          input.map(&:translate_repo)
        else
          translate_repo(input)
        end
      end

      def translate_repo(input)
        output = {}
        output['full_name'] = input['path_with_namespace']
        output['private'] = !input['public']
        output['ssh_url'] = input['ssh_url_to_repo']
        output['html_url'] = input['web_url']
        output['has_issues'] = input['issues_enabled']
        # XXX Need open_issues_count in GitLab!
        output
      end
    end
  end
end
