require "whiz/version"
require "whiz/dot_whiz"
require "whiz/config_file"
require "whiz/tome"

module Whiz
  def self.environment
    @@environment ||= (ENV['WHIZ_ENV'] || 'development').to_sym
  end

  def self.config
    @@config ||= Whiz::ConfigFile.load!
  end

  def self.boot!
    Whiz::DotWhiz.verify_dot_whiz!
    Whiz::DotWhiz.verify_config!
    Whiz::DotWhiz.verify_tomes!
  end
end

Whiz.boot!