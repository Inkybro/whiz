require 'whiz/folder/config_yaml'

module Whiz
  module Folder
    def self.whiz_path
      "#{home_path}/.whiz#{Whiz.environment == :test ? '_test' : nil}"
    end

    def self.verify_whiz_path!
      Dir.mkdir(whiz_path) unless Dir.exists?(whiz_path)
    end

    private

    def self.home_path
      ENV['HOME']
    end
  end
end