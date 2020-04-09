# Gem/Bundler
require 'rubygems'
require 'bundler/setup'

# Gemfile Requires
require 'ruby-lazy-const'

# Standard Requires
require 'pathname'

LazyConst::Config.base_dir = Pathname.new(__FILE__).parent.join('lib')

# TODO: Need to actually parse options
options = {
  ausearch_file: '/home/jcarson/git_clones/auditd-analyzer/assets/ausearch_cti_app2.txt'
}

Auditd::Analyzer::OpenCloseFd.new(options).run!
