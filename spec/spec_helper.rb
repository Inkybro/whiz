ENV['WHIZ_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'whiz'

def dot_whiz_path
  "#{ENV['HOME']}/.whiz_test"
end

def config_file
  "#{dot_whiz_path}/whiz.yaml"
end

def setup_dot_whiz!
  FileUtils.mkdir(dot_whiz_path) unless Dir.exists?(dot_whiz_path)
end

def teardown_dot_whiz!
  FileUtils.rm_r(dot_whiz_path)
end