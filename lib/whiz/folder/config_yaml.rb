require 'yaml'

module Whiz
  module Folder
    class ConfigYaml
      def self.default_options
        {
          current_tome: nil
        }
      end

      def self.config_file
        "#{Folder.dot_whiz_path}/whiz.yaml"
      end

      def self.verify_config!
        Whiz::Folder.verify_dot_whiz_path!
        if !File.exists?(config_file)
          File.open(config_file, 'w') do |f|
            f.print default_options.to_yaml
          end
        end
      end

      def self.load!
        verify_config!
        ConfigYaml.new(config_file)
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
end