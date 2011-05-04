require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'capistrano/configuration'
require 'capistrano/cli'

describe "CapistranoTags" do

  def load_gem_code
    load File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'capistrano-tags.rb'))
  end

  def stub_cli_response answer
    Capistrano::CLI.ui.stubs(:ask).returns(answer)
  end

  before(:each) do
    @config = Capistrano::Configuration.new
    Capistrano::Configuration.stubs(:instance).returns(@config)
  end

  after(:each) do
    # reset ENV variable used for test
    ENV['SVN_TAG'] = nil
    ENV['ASK_FOR_TAG'] = nil
  end

  describe "svn behavior" do

    before(:each) do
      @root = 'http://svn.example.org'
      @config.set(:scm, :subversion)
      @config.set(:repository_root, 'http://svn.example.org')
    end

    it "should deploy trunk with no configuration" do
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'trunk')
    end

    it "should deploy the given tag when :branch is set" do
      @config.set(:branch, '1.0')
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'tags', '1.0')
    end

    it "should deploy the given branch when :branch starts with branches/" do
      @config.set(:branch, 'branches/stable')
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'branches', 'stable')
    end

    it "should deploy the given tag when ENV['SVN_TAG'] is set" do
      ENV['SVN_TAG'] = '1.0'
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'tags', '1.0')
    end

    it "should deploy the given branch when ENV['SVN_TAG'] starts with 'branches/'" do
      ENV['SVN_TAG'] = 'branches/stable'
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'branches', 'stable')
    end

    it "should ask for tag when ENV['ASK_FOR_TAG'] is set" do
      ENV['ASK_FOR_TAG'] = '1'
      stub_cli_response '1.0.2'
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'tags', '1.0.2')
    end

    it "should deploy the given branch location when answer starts with 'branches/'" do
      ENV['ASK_FOR_TAG'] = '1'
      stub_cli_response 'branches/stable'
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'branches', 'stable')
    end

    it "should deploy trunk location when cli answer is empty" do
      ENV['ASK_FOR_TAG'] = '1'
      stub_cli_response ''
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'trunk')
    end

    it "should ask for tag when ask_for_tag is set to true" do
      @config.set(:ask_for_tag, true)
      stub_cli_response '1.0.2'
      load_gem_code
      @config.fetch(:repository).should == File.join(@root, 'tags', '1.0.2')
    end

  end
end
