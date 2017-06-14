require 'active_support'
require 'yaml'
require 'net/ssh'

require "dorsum/version"
require "dorsum/configuration"
require "dorsum/downloader"

module Dorsum
  mattr_accessor :configuration
  self.configuration ||= Configuration.new
end
