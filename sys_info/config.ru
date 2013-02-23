require File.expand_path(File.join(File.dirname(__FILE__), 'sys_info'))
use Rack::Reloader
run SysInfo.new