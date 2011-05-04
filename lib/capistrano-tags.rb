unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano-tags requires Capistrano 2"
end

Capistrano::Configuration.instance.load do

  def _cset(name, *args, &block)
    unless exists?(name)
      set(name, *args, &block)
    end
  end

  # if you include this file in your deploy.rb, you can use one of the following strategies
  # to change your deploy tag without editing the deploy.rb file
  # Git behavior
  if fetch(:scm) == :git
    # * set the :branch variable in your deploy.rb (normal workflow)
    # * set the GIT_TAG environment variable (it will override the branch variable)
    set(:branch, ENV['GIT_TAG']) if ENV['GIT_TAG'] and !ENV['GIT_TAG'].empty?
    if ENV['ASK_FOR_TAG'] or fetch(:ask_for_tag, false)
      # * set the :ask_for_tag or the ASK_FOR_TAG environment variable to true to be prompted for a tag
      set(:branch) do
        tag = Capistrano::CLI.ui.ask "Enter tag (or branch) to deploy:"
        tag.empty? ? 'HEAD' : tag
      end
    end
  end
  # Subversion behavior
  if fetch(:scm) == :subversion
    # * set the :branch variable in your deploy.rb (normal workflow)
    # * set the SVN_TAG environment variable (it will override the branch variable)
    set(:branch, ENV['SVN_TAG']) if ENV['SVN_TAG']
    # * set the :ask_for_tag variable to true to be prompted for a tag
    # * set the ASK_FOR_TAG environment variable to be prompted for a tag
    if ENV['ASK_FOR_TAG'] or fetch(:ask_for_tag, false)
      set(:branch) { Capistrano::CLI.ui.ask "Tag to deploy (leave it blank to deploy from trunk or use branches/xxx to deploy that branch): " }
    end
    # ensure repository root is set if using the recipe
    _cset(:repository_root) { abort "You must set your :repository_root to use this recipe" }
    # build the repository url
    set(:repository) do
      branch = fetch(:branch, '')
      branch = 'trunk' if branch.empty?
      branch = "tags/#{branch}" unless branch == 'trunk' or branch.start_with? 'branches/'
      File.join(fetch(:repository_root), branch)
    end
  end

  # task for querying svn tags
  # task for querying svn branches
end
