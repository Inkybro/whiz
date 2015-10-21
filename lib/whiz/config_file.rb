require 'yaml'

module Whiz
  class ConfigFile
    def self.default_options
      {
        current_tome: nil
      }
    end

    def self.load!
      Whiz::DotWhiz.verify_config!
      Whiz::ConfigFile.new(Whiz::DotWhiz.config_file)
    end

    attr_reader :filename, :data

    def initialize(filename)
      @filename = filename
      load_data!
    end

    def [](key)
      @data[key.to_sym]
    end

    def []=(key, value)
      @data[key.to_sym] = value
    end

    def save
      save_data!
    end

    private

    def load_data!
      @data = YAML::load_file(filename)
    end

    def save_data!
      File.open(filename, 'w') {|f| f.write @data.to_yaml }
    end
  end
end