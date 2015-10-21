require "whiz/version"
require "whiz/folder"
require "whiz/tome"

module Whiz
  def self.environment
    @@environment ||= (ENV['WHIZ_ENV'] || 'development').to_sym
  end

  def self.config
    @@config ||= Whiz::Folder::ConfigYaml.load!
  end

  def self.boot!
    Whiz::Folder.verify_dot_whiz!
    Whiz::Tome.verify_tomes!
  end
end

Whiz.boot!