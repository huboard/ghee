class Ghee
  module GitLab
    class RepoTranslator < Ghee::ApiTranslator
      def translate_hash(input)
        output = {}
        output['full_name'] = input['path_with_namespace']
        output['private'] = !input['public']
        output['ssh_url'] = input['ssh_url_to_repo']
        output['html_url'] = input['web_url']
        output['has_issues'] = input['issues_enabled']
        # This is only available in GitLab 8.3
        output['open_issues_count'] = input.fetch('issues_enabled', 0)
        output
      end
    end
  end
end
