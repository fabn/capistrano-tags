# capistrano-tags

Capistrano recipe for deploying svn or git tags with no need to edit the deploy file

## Installation

    gem install capistrano-tags

## Usage

In your deploy file require the capistrano-tags file after setting your variables with

    require 'capistrano-tags'

### Subversion usage

You MUST set the `repository_root` variable in your config file, then you can use one of the
following strategies to change the deployed tag when invoking `cap` command (assuming you have set
`:repository_root` to `http://svn.example.org`)

1. Set the ENV variable `SVN_TAG` when invoking capistrano

        $ SVN_TAG=1.0 cap:deploy # this will deploy http://svn.example.org/tags/1.0

2. Set the `:branch` variable to something i.e.

        set :branch, '1.0.2'           # this will deploy http://svn.example.org/tags/1.0.2
        set :branch, 'branches/stable' # this will deploy http://svn.example.org/branches/stable

3. Set the ENV variable `ASK_FOR_TAG` to anything, by doing this you'll be prompted for tag to deploy

        $ ASK_FOR_TAG=1 cap deploy
        Tag to deploy (leave it blank to deploy from trunk or use branches/xxx to deploy that branch): 1.0.3
        # this will deploy http://svn.example.org/tags/1.0.3
        $ ASK_FOR_TAG=1 cap deploy
        Tag to deploy (leave it blank to deploy from trunk or use branches/xxx to deploy that branch): branches/stable
        # this will deploy http://svn.example.org/branches/stable
        $ ASK_FOR_TAG=1 cap deploy
        Tag to deploy (leave it blank to deploy from trunk or use branches/xxx to deploy that branch):
        # this will deploy http://svn.example.org/trunk

4. Set the `:ask_for_tag` variable to true in your config, you'll be prompted for the tag as above

As you may have seen, when you set the `:branch` variable in any of the given way, if its value is empty,
it will be defaulted to `trunk`, so keep in mind that. Moreover if the `:branch` variable content starts with
`branches/` then a branch (instead of a tag) will be deployed. There's no need to prepend the variable with `tags`
if you just want to deploy a tag.

### Git usage

In this case there's no need to set the `:repository_root` variable, because git supports the `:branch`
variable. So you can deploy a branch or a tag by setting the `:repository` variable and then you can do
one of the following

1. Set the ENV variable `SVN_TAG` when invoking capistrano

        $ SVN_TAG=1.0 cap:deploy # this will deploy refs/tags/1.0

2. Set the `:branch` variable to something i.e.

        set :branch, '1.0.2'    # this will deploy refs/tags/1.0.2
        set :branch, 'stable'   # this will deploy refs/heads/stable

3. Set the ENV variable `ASK_FOR_TAG` to anything, by doing this you'll be prompted for tag to deploy

        $ ASK_FOR_TAG=1 cap deploy
        Enter tag (or branch) to deploy: 1.0.3
        # this will deploy refs/tags/1.0.3
        $ ASK_FOR_TAG=1 cap deploy
        Enter tag (or branch) to deploy: stable
        # this will deploy refs/heads/stable
        $ ASK_FOR_TAG=1 cap deploy
        Enter tag (or branch) to deploy:
        # this will deploy refs/heads/master

4. Set the `:ask_for_tag` variable to true in your config, you'll be prompted for the tag as above

In this case if the `:branch` variable is empty then the `master` branch will be deployed.

## Contributing to capistrano-tags
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Fabio Napoleoni. See LICENSE.txt for
further details.

