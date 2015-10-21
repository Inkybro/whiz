require 'whiz/folder/config_yaml'

module Whiz
  module Folder
    def self.dot_whiz_path
      "#{home_path}/.whiz#{Whiz.environment == :test ? '_test' : nil}"
    end

    def self.verify_dot_whiz_path!
      Dir.mkdir(dot_whiz_path) unless Dir.exists?(dot_whiz_path)
    end

    private

    def self.home_path
      ENV['HOME']
    end
  end
end