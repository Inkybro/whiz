module Whiz
  class Tome
    def self.find(name)
      tome = Whiz::Tome.new(name)
      tome.saved? ? tome : nil
    end

    def self.create(name)
      tome = Whiz::Tome.new(name)
      !tome.saved? ? tome.save : nil
    end

    def self.find_or_create(name)
      find(name) || create(name)
    end

    def self.current=(tome)
      Whiz.config[:current_tome] = tome ? tome.to_sym : nil
      Whiz.config.save
    end

    def self.current
      Whiz::Tome.new(Whiz.config[:current_tome]) if Whiz.config[:current_tome]
    end

    def self.all
      Dir.glob("#{Whiz::DotWhiz.tomes_path}/*").map do |tome_path|
        Whiz::Tome.new(tome_path.split('/').last)
      end
    end

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def save
      FileUtils.mkdir_p(tome_path) unless saved?
      self
    end

    def saved?
      Dir.exists?(tome_path)
    end

    def destroy
      if saved?
        FileUtils.rm_r(tome_path)
        if name == Whiz.config[:current_tome]
          Whiz.config[:current_tome] = nil
          Whiz.config.save
        end
        true
      else
        false
      end
    end

    private

    def tome_path
      "#{Whiz::DotWhiz.tomes_path}/#{name}"
    end
  end
end