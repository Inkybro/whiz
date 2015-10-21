module Whiz
  module DotWhiz
    def self.dot_whiz_path
      "#{home_path}/.whiz#{Whiz.environment == :test ? '_test' : nil}"
    end

    def self.verify_dot_whiz!
      Dir.mkdir(dot_whiz_path) unless Dir.exists?(dot_whiz_path)
    end

    def self.config_file
      "#{Whiz::DotWhiz.dot_whiz_path}/whiz.yaml"
    end

    def self.verify_config!
      Whiz::DotWhiz.verify_dot_whiz!
      if !File.exists?(config_file)
        File.open(config_file, 'w') do |f|
          f.print Whiz::ConfigFile.default_options.to_yaml
        end
      end
    end

    def self.tomes_path
      "#{Whiz::DotWhiz.dot_whiz_path}/tomes"
    end

    def self.verify_tomes!
      Whiz::DotWhiz.verify_dot_whiz!
      FileUtils.mkdir(tomes_path) unless Dir.exists?(tomes_path)
    end

    private

    def self.home_path
      ENV['HOME']
    end
  end
end