require 'json'
require 'httpclient'
require 'kinkou/version'
require 'kinkou/tracker'
require 'kinkou/configuration'

module Kinkou
  def self.bind
    Kinkou::Tracker.bind
  end

  def self.configure
    yield config
  end

  def self.config
    Configuration.instance
  end
end
