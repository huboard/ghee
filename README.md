Ghee
==================

This is an unofficial ruby client for the [GitHub API](http://developer.github.com/v3/). The end goal is a complete, simple, and intuitive ruby API for all things Github.

Usage
-----

Instantiate the client:

    access_token = "abcd1234"
    gh = Ghee.new(access_token)

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

### Events

List public events:

    gh.events

Testing
-------

The test suite uses [VCR](https://github.com/myronmarston/vcr) to cache actual requests to the Github API in a directory called responses in the spec directory. In order for VCR to make and cache the actual calls to the Github API you will need to provide your Github access_token by placing it in a file named .access_token in the spec directory.

This file is ignored by git (see .gitignore) so you can commit any changes you make to the gem without having to worry about your token being released into the wild.

Now run the test suite:

    bundle
    bundle exec rake

CONTRIBUTE
----------

If you'd like to hack on Ghee, start by forking the repo on GitHub:

https://github.com/jonmagic/ghee

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