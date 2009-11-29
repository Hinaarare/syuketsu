#!/usr/bin/env ruby

require 'webrick'

# rubyへのパスを書く
rubybin = '/opt/local/bin/ruby'

document_root = File.dirname(File.expand_path(__FILE__)) + "/../public"
puts document_root
server = WEBrick::HTTPServer.new({
  :DocumentRoot => document_root,
  :BindAddress => 'localhost',
  :CGIInterpreter => rubybin,
  :Port => 4989
})


['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.start
