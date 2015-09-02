Ghee
==================

This is an unofficial ruby client for the [GitHub API](http://developer.github.com/v3/). The end goal is a complete, simple, and intuitive ruby API for all things Github.

# Usage

Instantiate the client with basic auth:

    gh = Ghee.basic_auth("rauhryan","password")

Instantiate the client with auth token:

    gh = Ghee.access_token("1234oijgakjioewj1o4oij")

Create an OAuth access token:

    user_name, password, scopes = "rauhryan", "secret", ["user","repo"]
    token = Ghee.create_token(user_name, password, scopes)

Create a client for github enterprise
    
    gh = Ghee.access_token("your_token","https://foo.com")
    gh = Ghee.basic_auth("your_user", "your_pass", "https://foo.com")

## Gists

### Usage

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

### Comments

List comments for a gist:

    gh.gists("1382919").comments

Get a single gist comment:

    gh.gists.comments("1231414")

Create a single gist comment: 

    gh.gists.comments("1231414").create({
       :body => "new body"
    })

Patch a single gist comment: 

    gh.gists.comments("1231414").patch({
       :body => "new body"
    })

Delete a comment for a gist: 

    gh.gists.comments("1231441").destroy



## Repos                                

Get a single repo:

    gh.repos("rauhryan", "ghee")

### Pulls

List pull requests on a repo (see [List pull requests](http://developer.github.com/v3/pulls/#list-pull-requests) )


    gh.repos("rauhryan", "ghee").pulls

    gh.repos("rauhryan", "ghee").pulls({
      :state => "closed" # optional
    })
    
Get a single pull request on a repo (see [Get a single pull request](http://developer.github.com/v3/pulls/#get-a-single-pull-request) )

    gh.repos("rauhryan", "ghee").pulls(1097)
    
Create a pull request (see [Create a pull request](http://developer.github.com/v3/pulls/#create-a-pull-request) )

    gh.repos("rauhryan", "ghee").pulls.create({
        :title=>"take my awesome code!",
        :body=>"This code is so awesome. Let me tell you why...",
        :base=>"master",
        :head=>"octocat:awesomebranch"
    })
    
Update a pull request (see [Update a pull request](http://developer.github.com/v3/pulls/#update-a-pull-request) )

    gh.repos("rauhryan", "ghee").pulls(1097).patch({:title=>"New title", :body=>"New body", :state=>"closed"})
    
List commits on a pull request (see [List commits a pull request](http://developer.github.com/v3/pulls/#list-commits-on-a-pull-request) )

    gh.repos("rauhryan", "ghee").pulls(1097).commits
    
List files on a pull request (see [List files a pull request](http://developer.github.com/v3/pulls/#list-pull-requests-files) )

    gh.repos("rauhryan", "ghee").pulls(1097).files

Get if a pull request has been merged (see [Get if a pull request has been merged](http://developer.github.com/v3/pulls/#get-if-a-pull-request-has-been-merged) )

    gh.repos("rauhryan", "ghee").pulls(1097).merged? #=> true

Merge a pull request (see [Merge a pull request](http://developer.github.com/v3/pulls/#merge-a-pull-request-merge-buttontrade) )

    gh.repos("rauhryan", "ghee").pulls(1097).merge!  
    gh.repos("rauhryan", "ghee").pulls(1097).merge!("It's like hitting the Merge Button(TM)")

### Commits

List commits on a repo:

    gh.repos("rauhryan", "ghee").commits

    gh.repos("rauhryan", "ghee").commits({
      :sha => "awesome_branch" # optional
    })

    gh.repos("rauhryan", "ghee").commits( {
      :path => "/path/to/file" # only commits containing this path
    })

Get a single commit:

    gh.repos("rauhryan", "ghee").commits("sha")

List commit comments for a repo:

    gh.repos("rauhryan", "ghee").comments

List comments for a single commit:

    gh.repos("rauhryan", "ghee").commits("sha").comments

Create a commit comment:

    gh.repos("rauhryan", "ghee").commits("sha").comments.create({
      :body => "sweet codez yo!", #required
      :commit_id => "sha", #required
      :line => 123, #required
      :path => "/path/to/file", #required
      :position => 4 #required
    })

Get a single commit comment:

    gh.repos("rauhryan", "ghee").comments(123)

Update a commit comment:

    gh.repos("rauhryan", "ghee").comments(123).patch(:body => "new text")

Destroy a commit comment: 

    gh.repos("rauhryan", "ghee").comments(123).destroy

Compare two commits:

    gh.repos("rauhryan", "ghee").compare("basesha","headsha")

### Collaborators

List a repos collaborators:

    gh.repos("rauhryan", "ghee").collaborators
    
Get a single collaborator:

    gh.repos("rauhryan", "ghee").collaborators("herp") # => false

    gh.repos("rauhryan", "ghee").collaborators("jonmagic") # => true

Add a collaborator:

    gh.repos("rauhryan", "ghee").collaborators.add("herp") # => true
    
Remove a collaborator:

    gh.repos("rauhryan", "ghee").collaborators.remove("herp") # => true

### Forks

List the hooks for a repo:

    gh.repos("rauhryan", "ghee").forks

    gh.repos("rauhryan", "ghee").forks(:sort => "newest") # => `newest`, `oldest`, `watchers`

Create a fork:

    gh.repos("rauhryan", "ghee").forks.create # => forks the repo to the authenticated user

### Keys

List the keys for a repo:

    gh.repos("rauhryan", "ghee").keys
  
Get a single key for a repo:

    gh.repos("rauhryan", "ghee").keys(123)

Create a key for a repo: 
  
    gh.repos("rauhryan", "ghee").keys.create({
      :title => "customer deploy key",
      :key => "ssh-rsa AAA ..."
    })

Update a key for a repo: 
  
    gh.repos("rauhryan", "ghee").keys.patch({
      :title => "customer deploy key",
      :key => "ssh-rsa AAA ..."
    })

Destroy a key for a repo: 

    gh.repos("rauhryan", "ghee").keys(123).destroy # => true


### Hooks

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

### Downloads

Get the downloads for a repo:

    gh.repos("rauhryan", "ghee").downloads

Get a single download for a repo:

    gh.repos("rauhryan", "ghee").downloads(12)

Create a download for a repo:

    gh.repos("rauhryan", "ghee").downloads.create("/path/to/file","description")

Destroy a download for a repo: 

    gh.repos("rauhryan", "ghee").downloads(12).destroy

### Watchers

List watchers for a repo:

    gh.repos("rauhryan", "ghee").watchers

List repos being watched:

    gh.user.watched
    
    gh.users("jonmagic").watched

Check if you are watching a repo:

    gh.user.watching? "rauhryan", "huboard"

Watch a repo:

    gh.user.watch "rauhryan", "huboard"

Unwatch a repo: 

    gh.user.watch! "rauhryan", "huboard"

### Milestones

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

### Issues

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

### Comments

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

## Orgs

### Usage

Get a list of orgs for the current user:

    gh.orgs

Get a specific org:

    gh.orgs("huboard")

Patch an organization:([see docs for all possible params](http://developer.github.com/v3/orgs#edit)):

    gh.orgs("huboard").patch({ :company => "awesome company" })

### Repos

Get a list of repos for an org:

    gh.orgs("huboard").repos

> Notes: see above for all the available api methods for repos

### Teams

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

### Members

Get a list of members for a team:

    gh.orgs("huboard").teams(110234).members

Add a member to a team:

    gh.orgs("huboard").teams(110234).members.add("rauhryan")

Remove a member from a team:

    gh.orgs("huboard").teams(110234).members.remove("rauhryan")

## Teams

### Usage

Get a single team:

    gh.team(110234)

Create a team: 

    gh.team.create :name => "awesome_developers"

Patch a team:

    gh.team(110234).patch :name => "junior_developers"

Delete a team:

    gh.team(110234).delete

### Members

Get a list of members for a team:

    gh.team(110234).members

Add a member to a team:

    gh.team(110234).members.add("rauhryan")

Remove a member from a team:

    gh.team(110234).members.remove("rauhryan")

## Users

### Usage

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

### Keys

List the keys for a user:

    gh.user.keys
  
Get a single key for a user:

    gh.user.keys(123)

Create a key for a user: 
  
    gh.user.keys.create({
      :title => "customer deploy key",
      :key => "ssh-rsa AAA ..."
    })

Update a key for a user: 
  
    gh.user.keys.patch({
      :title => "customer deploy key",
      :key => "ssh-rsa AAA ..."
    })

Destroy a key for a user: 

    gh.user.keys(123).destroy # => true

### Repos

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

### Followers

Get the followers for a user:

    gh.user.followers

    gh.users("rauhryan").followers

Get users following another user:

    gh.users("rauhryan").following

    gh.user.following

Check if you are following a user:

    gh.user.following? "rauhryan"

Follow a user:

    gh.user.follow "rauhryan"

Unfollow a user:

    gh.user.follow! "rauhryan"

## Git Data

### Blobs

Get a blob:

    gh.repos("rauhryan","huboard").git.blobs("sha")

Create a blob:

    gh.repos("rauhryan","huboard").git.blobs.create({
      :content => "Contents of blob",
      :encoding => "utf-8"
    })


### Commit

Get a commit:

    gh.repos("rauhryan","huboard").git.commits("sha")

Create a commit:

    gh.repos("rauhryan","huboard").git.commits.create({
      :message => "message of commit",
      :tree => "sha",
      :parents => ["sha","sha"]
    })

### References

Get a reference:

    gh.repos("rauhryan","huboard").git.refs("heads/master")

Get all references:

    gh.repos("rauhryan","huboard").git.refs

    gh.repos("rauhryan","huboard").git.refs("tags")

    gh.repos("rauhryan","huboard").git.refs("heads")

Create a reference:

    gh.repos("rauhryan","huboard").git.refs.create({
        :ref => "refs/heads/master",
        :sha => "287efc2351325e215j235f25215el1"
      })

Update a reference:

    gh.repos("rauhryan","huboard").git.refs("heads/master").patch({
        :sha => "287efc2351325e215j235f25215el1",
        :force => true
      })

Delete a reference:

    gh.repos("rauhryan","huboard").git.refs("tags/v1.0").destroy
    
### Tags

Get a tag:

    gh.repos("rauhryan","huboard").git.tags("sha")

Create a tag:

    gh.repos("rauhryan","huboard").git.tags.create({
        :tag => "v1.0",
        :message => "tag message",
        :object => "sha", #sha of the object you are tagging, usually a commit
        :type => "commit", #the type of object you are tagging
        :tagger => {
           :name => "Ryan Rauh",
           :email => "rauh.ryan@gmail.com",
           :date => "2011-06-17T14:53:35-07:00"
        }
      })

### Trees

Get a tree:

    gh.repos("rauhryan","huboard").git.trees("sha")

Get a tree recursively:

    gh.repos("rauhryan","huboard").git.trees("sha",{:recursive => 1})

Create a tree:

    gh.repos("rauhryan","huboard").git.trees.create({
        :base_tree => "sha", #optional
        :tree => [
          {
            :path => "/path/to/thing",
            :mode => 100644,
            :type => "blob",
            :sha => "sha"
            # :content => "" # can use this instead of sha
          }
        ]
    })
    

## Events

### Usage

List public events:

    gh.events

## Pagination

### Usage

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

## Filtering parameters

### Usage

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

In order for VCR to make and cache the actual calls to the Github API you will need to copy spec/settings.yml.sample to spec/settings.yml and configure it with your GitHub username, either a GitHub access token or your GitHub password, a test repo for it to hit against (which you should setup ahead of time), and finally an organization you belong to (for the entire suite of tests to pass you have to belong to an org).

This file is ignored by git (see .gitignore) so you can commit any changes you make to the gem without having to worry about your user/token/pass/org being released into the wild.

Before  you run the api test suite:

    Fork [Ghee-Test](https://github.com/rauhryan/ghee_test)
    Set the settings.yml repo key to ghee_test
    On ghee_test:
     - Enable issue tracking on (your username)/ghee
     - Create a Public Gist and Star it
     - Create an issue with the title "Seeded"
     - Create a comment on a commit line

Now run the test suite:

    bundle
    bundle exec rake api

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
