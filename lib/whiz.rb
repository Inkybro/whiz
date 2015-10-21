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
    Folder.verify_dot_whiz_path!
  end
end

Whiz.boot!