require 'erubis'

module Whiz
  class Page
    Error = Class.new(StandardError)

    def self.exists?(name)
      Whiz::Page.new(name).saved?
    end

    attr_reader :name, :tome

    def initialize(name)
      @name = name
      @tome = Whiz::Tome.current

      fail_with('A current tome must be set!', self) unless @tome
    end

    def edit
      File.open(page_path, 'w') unless saved?
      system('nano', page_path)
    end

    def destroy
      if saved?
        FileUtils.rm(page_path)
        true
      else
        false
      end
    end

    def saved?
      File.exists?(page_path)
    end

    def generate(filename, locals={})
      src = render(locals)
      File.open(filename, 'w') {|f| f.write src }
      puts src
      puts
    end

    private

    def page_path
      "#{Whiz::DotWhiz.tomes_path}/#{tome.name}/#{name}"
    end

    def read_page
      File.read(page_path)
    end

    def render(locals={})
      return unless saved?
      Erubis::Eruby.new(read_page).result(locals)
    end

    def fail_with(*args)
      fail self.class::Error, sprintf(*args)
    end
  end
end