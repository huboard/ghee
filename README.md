Ghee
==================

This is an unofficial ruby client for the [GitHub API](http://developer.github.com/v3/). The end goal is a complete, simple, and intuitive ruby API for all things Github.

Usage
-----

Instantiate the client with basic auth:

    gh = Ghee.basic_auth("rauhryan","password")

Instantiate the client with auth token:

    gh = Ghee.access_token("1234oijgakjioewj1o4oij")

Create an OAuth access token:

    user_name, password, scopes = "rauhryan", "secret", "repos, user"
    token = Ghee.create_token(user_name, password, scopes)

### Gists

List a user's gists:

    gh.user('jonmagic').gists

List authenticated users gists:

    gh.gists

List all public gists:

    gh.gists.public

List the authenticated user's starred gists:

    gh.gists.starred

Get a single gist:

    gist_id = "1393990"
    gh.gists(gist_id)

Create a gist ([see docs for all possible params](http://developer.github.com/v3/gists/#create-a-gist)):

    gh.gists.create({
      :description => 'Ghee'
      :public => true,
      :files => {
        'file1.txt' => {
          :content => 'buttah yo bread'
        }
      }
    })

Edit a gist:

    gh.gists("1393990").patch({
      :files => {
        'gistfile1.md' => {
          :content => 'clarified I say'
        }
      }
    })

Star a gist:

    gh.gists("1393990").star

Unstar a gist:

    gh.gists("1393990").unstar

Check if a gist is starred:

    gh.gists("1393990").starred?

Delete a gist:

    gh.gists("1393990").destroy

### Repos

Get a single repo:

    gh.repos("rauhryan", "ghee")

Get the hooks for a repo:

    gh.repos("rauhryan", "ghee").hooks

Get a single hook for a repo:

    gh.repos("rauhryan", "ghee").hooks(12)

Create a hook for a repo: ([see docs for all possible params](http://developer.github.com/v3/hooks/#create-an-hook)):

    gh.repos("rauhryan", "ghee").hooks.create({
      :name => "web",
      :config => {:url => "http://huboard.com/webhook"}
    })

Update a hook for a repo: ([see docs for all possible params](http://developer.github.com/v3/hooks/#edit-an-hook)):

    gh.repos("rauhryan", "ghee").hooks(12).patch({
      :name => "web",
      :config => {:url => "http://huboard.com/webhook"}
    })

Destroy a hook for a repo:

    gh.repos("rauhryan", "ghee").hooks(1).destory

Get the milestones for a repo:

    gh.repos("rauhryan", "ghee").milestones

Get a single milestone for a repo:

    gh.repos("rauhryan", "ghee").milestones(12)

Create a milestone for a repo: ([see docs for all possible params](http://developer.github.com/v3/milestones/#create-an-milestone)):

    gh.repos("rauhryan", "ghee").milestones.create({
      :title => "Remove the suck!",
      :description => "I found this suck, remove it please"
    })

Update a milestone for a repo: ([see docs for all possible params](http://developer.github.com/v3/milestones/#edit-an-milestone)):

    gh.repos("rauhryan", "ghee").milestones(12).patch({
      :description => "I found this suck, remove it please"
    })

Destroy a milestone for a repo:

    gh.repos("rauhryan", "ghee").milestones(1).destory

Get the issues for a repo:

    gh.repos("rauhryan", "ghee").issues

Get a single issue for a repo:

    gh.repos("rauhryan", "ghee").issues(12)

Create an issue for a repo: ([see docs for all possible params](http://developer.github.com/v3/issues/#create-an-issue)):

    gh.repos("rauhryan", "ghee").issues.create({
      :title => "Remove the suck!",
      :body => "I found this suck, remove it please"
    })

Update an issue for a repo: ([see docs for all possible params](http://developer.github.com/v3/issues/#edit-an-issue)):

    gh.repos("rauhryan", "ghee").issues(12).patch({
      :body => "I found this suck, remove it please"
    })

Close an issue for a repo:

    gh.repos("rauhryan", "ghee").issues(12).close

Get the closed issues for a repo:

    gh.repos("rauhryan", "ghee").issues(12).closed

Get the comments for an issue:

    gh.repos("rauhryan", "ghee").issues(12).comments

Get a single comment for an issue

    gh.repos("rauhryan", "ghee").issues.comments(482910)

Create a comment for an issue:

    gh.repos("rauhryan", "ghee").issues(12).comments.create({:body => "hey i'll help fix that suck"})

Update a single comment for an issue

    gh.repos("rauhryan", "ghee").issues.comments(482910).patch({:body =>
          "nevermind I can't figure it out"})

Destroy a comment for an issue

    gh.repos("rauhryan", "ghee").issues.comments(482910).destroy

### Orgs

Get a list of orgs for the current user:

    gh.orgs

Get a specific org:

    gh.orgs("huboard")

Patch an organization:([see docs for all possible params](http://developer.github.com/v3/orgs#edit)):

    gh.orgs("huboard").patch({ :company => "awesome company" })

Get a list of repos for an org:

    gh.orgs("huboard").repos

> Notes: see above for all the available api methods for repos

Get a list of teams for an org:

    gh.orgs("huboard").teams

Get a single team for an org:

    gh.orgs("huboard").teams(110234)

Create team for an org:

    gh.orgs("huboard").teams.create :name => "awesome_developers"

Patch a team for an org:

    gh.orgs("huboard").teams(110234).patch :name => "junior_developers"

Delete a team for an org:

    gh.orgs("huboard").teams(110234).delete

Get a list of members for a team:

    gh.orgs("huboard").teams(110234).members

Add a member to a team:

    gh.orgs("huboard").teams(110234).members.add("rauhryan")

Remove a member from a team:

    gh.orgs("huboard").teams(110234).members.remove("rauhryan")

### Teams

Get a single team:

    gh.team(110234)

Create a team:

    gh.team.create :name => "awesome_developers"

Patch a team:

    gh.team(110234).patch :name => "junior_developers"

Delete a team:

    gh.team(110234).delete

Get a list of members for a team:

    gh.team(110234).members

Add a member to a team:

    gh.team(110234).members.add("rauhryan")

Remove a member from a team:

    gh.team(110234).members.remove("rauhryan")

### Users

Get a single user:

    gh.users('jonmagic')


Get the authenticated user:

    gh.user

Update authenticated user ([see docs for all possible params](http://developer.github.com/v3/users/#update-the-authenticated-user)):

    gh.user.patch({
      :name => 'Jon Hoyt',
      :email => 'jonmagic@gmail.com',
      # …etc
    })

Get a list of repos for the current user:

    gh.user.repos

Get a list of repos for a specific user:

    gh.users("rauhryan").repos

Get a single repos for the current user:

    gh.user.repos("ghee")

Get a single repos for a specific user:

    gh.users("rauhryan").repos("ghee")

> Notes: see above for all the available api methods for repos

Get a list of orgs for the current user:

    gh.user.orgs

Get a list of orgs for a specific user:

    gh.users("rauhryan").orgs

> Notes: see above for all the available api methods for orgs

### Events

List public events:

    gh.events

### Pagination

Ghee fully supports pagination for anything that returns a list, for
example repo issues.

    gh.repos("rauhryan","huboard").issues.paginate(:per_page => 30, :page => 1) #=> returns first page of issues
    gh.repos("rauhryan","huboard").issues.paginate(:per_page => 30, :page => 2) #=> returns page two of issues
    gh.repos("rauhryan","huboard").issues.paginate(:per_page => 30, :page => 2).first_page #=> 1
    gh.repos("rauhryan","huboard").issues.paginate(:per_page => 30, :page => 2).last_page #=> 4
    gh.repos("rauhryan","huboard").issues.paginate(:per_page => 30, :page => 2).next_page #=> 3
    gh.repos("rauhryan","huboard").issues.paginate(:per_page => 30, :page => 2).prev_page #=> 1

Ghee also provides a convienence method for all the pages

    gh.repos("rauhryan","huboard").issues.all #=> return all the pages

### Filtering parameters

Many of the api calls allow you to pass in additional paramters to
filter and sort your data, for example issues provide

 * filter
    * `assigned`
    * `mentioned`
    * `subscribed`
    * `created`
 * state
    * `open` `closed` `default`
 * labels
    * list of labels comma delimited `herp,derp`
 * direction
    * `asc` or `desc`

These can all be passed into ghee through an options hash:

    gh.repos("rauhryan", "huboard").issues(:state => "closed", :sort => "desc")

> Note you can also change parameters with pagination!

    gh.repos("rauhryan", "huboard").issues(:state => "closed").all

Testing
-------

The test suite uses [VCR](https://github.com/myronmarston/vcr) to cache actual requests to the Github API in a directory called responses in the spec directory.

Responses are cached and ship with the repository, but you can delete everything in spec/responses to run against the actualy GitHub API. If you need to commit changes to the response files, make sure to run "bundle exec rake scrub" first to remove any sensitive passwords or tokens from the responses.

In order for VCR to make and cache the actual calls to the Github API you will need to copy spec/settings.yml.sample to spec/settings.yml and configure it with your GitHub username, either a GitHub access token or your GitHub password, a test repo for it to hit against (which you should setup ahead of time), and finally an organization you belong to (for the entire suite of tests to pass you have to belong to an org).

This file is ignored by git (see .gitignore) so you can commit any changes you make to the gem without having to worry about your user/token/pass/org being released into the wild.

Now run the test suite:

    bundle
    bundle exec rake

CONTRIBUTE
----------

If you'd like to hack on Ghee, start by forking the repo on GitHub:

https://github.com/rauhryan/ghee

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `bundle exec rake`
1. If you are adding new functionality, document it in the README
1. Do not change the version number, we will do that on our end
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch

Contributors
------------
* [Jonathan Hoyt](https://github.com/jonmagic)
* [Ryan Rauh](https://github.com/rauhryan)
