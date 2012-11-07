puts "XXX: loading Capper 5"

require "dedent"

require "capper/version"

# mixin various helpers
require 'capper/utils/templates'
include Capper::Utils::Templates

require 'capper/utils/multistage'
include Capper::Utils::Multistage

require 'capper/utils/monit'
include Capper::Utils::Monit

require 'capper/utils/bluepill'
include Capper::Utils::Bluepill

# see https://github.com/capistrano/capistrano/issues/168
Capistrano::Configuration::Namespaces::Namespace.class_eval do
  def capture(*args)
    parent.capture *args
  end
end

# make sure capper recipes can be found by load() too
Capistrano::Configuration.instance(true).load do
  load_paths << File.expand_path(File.dirname(__FILE__))
  load 'capper/base'
end
