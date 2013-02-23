require 'rubygems'
require 'rack'
require 'ohai'

class SysInfo

  def initialize
  	@ohai = Ohai::System.new
  	@ohai.all_plugins
  end

  def call(env)
  	route = self.class.route(env["PATH_INFO"])
  	route ? render({:content => send(route[:method])}) : render_404
  end

  def index
  	m = @ohai.memory
  	content = "<h1>Welcome to the SysInfo home page</h1>"
  	content << "Used memory: #{format(m['total'].to_i - m['free'].to_i)}<br/>"
  	content << "Used disc space: #{format(_disc()[:used])}"
  	content
  end

  def memory
  	m = @ohai.memory
  	"<h1>Memory info</h1>Free: #{format(m['free'].to_i)}<br/>Total: #{format(m['total'].to_i)}"
  end

  def disc
  	info = _disc
  	"<h1>Disc info</h1>Used: #{format(info[:used])}<br/>Total: #{format(info[:total])}"
  end

  def help
  	content = []
  	self.class.routes.each do |k,v|
  		content << "<a href='#{k}'>#{k}</a>: #{v[:description]}"
  	end
  	"<h1>Help page</h1>#{content.join('<br/>')}"
  end

  private

  def render_404
  	render :content => "Page not found", :code => 404
  end

  def render(args={})
  	a = {:content => "", :code => 200, :type => "text/html"}.merge(args)
  	[a[:code], {"Content-Type" => a[:type]}, [a[:content]]]
  end

  def format(size)
  	sizes = %w{kb mb gb tb pb eb}
  	i = 0
  	while (size / 1024) > 1 do
  		size /= 1024.0
  		i += 1
  	end
  	"%.2f %s" % [size, sizes[i]]
  end

  def _disc
  	total = used = 0
  	@ohai.filesystem.each do |k, v|
  		used += (@ohai.filesystem[k]['kb_used'] || 0).to_i
  		total += (@ohai.filesystem[k]['kb_size'] || 0).to_i
  	end
  	{total: total.to_i*1024, used: used.to_i*1024}
  end

  class << self

	  def map(url, args={})
	  	@routes ||= {}
	  	@routes[url] = args
	  end

	  def route(url)
	  	@routes[url]
	  end

	  def routes
	  	@routes
	  end
  end

  map '/', :method => :index, :description => "Home page"
  map '/memory', :method => :memory, :description => "Page with memory usage"
  map '/disc', :method => :disc, :description => "Page with disc usage"
  map '/help', :method => :help, :description => "Page with info about all routes"
end