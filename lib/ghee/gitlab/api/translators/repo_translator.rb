class Ghee
  module GitLab
    class RepoTranslator < Ghee::ApiTranslator
      def translate_hash(input)
        output = {}
        output['name'] = input['name']
        output['full_name'] = input['path_with_namespace']
        output['private'] = !input['public']
        output['ssh_url'] = input['ssh_url_to_repo']
        output['html_url'] = input['web_url']
        output['has_issues'] = input['issues_enabled']

        output['permissions'] = {}

        # XXX Project owners are not considered project members, so checking
        # the permissions is not adequate.
        admin_access = false
        push_access = false
        pull_access = false

        # Permissions do not come standard in older versions of GitLab
        if input['permissions']
          puts input['permissions']
          group_perms = input['permissions']['group_access']
          project_perms = input['permissions']['project_access']

          if group_perms
            level = group_perms['access_level'].to_i
            admin_access = level >= ::Ghee::GitLab::AccessLevels::MASTER
            push_access = level >= ::Ghee::GitLab::AccessLevels::DEVELOPER
            pull_access = level >= ::Ghee::GitLab::AccessLevels::DEVELOPER
          end

          if project_perms
            level = project_perms['access_level'].to_i
            admin_access |= level >= ::Ghee::GitLab::AccessLevels::MASTER
            push_access |= level >= ::Ghee::GitLab::AccessLevels::DEVELOPER
            pull_access |= level >= ::Ghee::GitLab::AccessLevels::DEVELOPER
          end
        end

        output['permissions']['admin'] = admin_access
        output['permissions']['push'] = push_access
        output['permissions']['pull'] = pull_access

        output['owner'] = {}

        # Projects belonging to a group do not have an owner but do have
        # namespace
        if input['owner']
          output['owner']['login'] = input['owner']['username']
        elsif input['namespace']
          output['owner']['login'] = input['namespace']['path']
        end

          # This is only available in GitLab 8.3
        output['open_issues_count'] = input.fetch('open_issues_count', 0)
        output
      end
    end
  end
end
