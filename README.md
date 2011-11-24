Ghee
==================

This is an unofficial ruby client for the [Github API](http://developer.github.com/v3/). The end goal is a complete, simple, and intuitive ruby API for all things Github.

Usage
-----

Instantiate the client:

    access_token = "abcd1234"
    gh = Ghee.new(access_token)

Testing
-------

The test suite uses [VCR](https://github.com/myronmarston/vcr) to cache actual requests to the Github API in a directory called responses in the spec directory. In order for VCR to make and cache the actual calls to the Github API you will need to provide your Github access_token by placing it in a file named .access_token in the spec directory.

This file is ignored by git (see .gitignore) so you can commit any changes you make to the gem without having to worry about your token being released into the wild.

Now run the test suite:

    bundle
    bundle exec rake