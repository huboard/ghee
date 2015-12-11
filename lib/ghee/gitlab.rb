class Ghee
  def self.private_token(token, api_url = nil)
    options = { :private_token => token }
    options[:enable_url_escape] = false
    options[:api_url] = api_url if api_url
    Ghee.new options
  end

  module GitLab
    module API
    end
  end
end

#require 'ghee/gitlab/api/authorizations'
#require 'ghee/gitlab/api/gists'
#require 'ghee/gitlab/api/users'
#require 'ghee/gitlab/api/events'
require 'ghee/gitlab/api/repos'
#require 'ghee/gitlab/api/issues'
#require 'ghee/gitlab/api/milestones'
#require 'ghee/gitlab/api/orgs'
#require 'ghee/gitlab/api/git_data'
#require 'ghee/gitlab/api/labels'
#require 'ghee/gitlab/api/hooks'
#require 'ghee/gitlab/api/collaborators'
#require 'ghee/gitlab/api/forks'
#require 'ghee/gitlab/api/commits'
#require 'ghee/gitlab/api/commit_comments'
#require 'ghee/gitlab/api/commit_statuses'
#require 'ghee/gitlab/api/keys'
#require 'ghee/gitlab/api/watchers'
#require 'ghee/gitlab/api/emails'
#require 'ghee/gitlab/api/followers'
#require 'ghee/gitlab/api/pulls'
#require 'ghee/gitlab/api/search'
#require 'ghee/gitlab/api/contents'
#require 'ghee/gitlab/api/members'

require 'ghee/gitlab/translators/repo_translator'
