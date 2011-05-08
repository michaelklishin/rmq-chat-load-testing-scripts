#!/usr/bin/env ruby
require 'vendor/web_socket'

require 'digest/md5'
md5 = Digest::MD5.new

require 'rubygems'
require 'json'

$message = 'This is spam.'

Thread.new do
  client = WebSocket.new("ws://69.195.198.92:8080/server")
  
  while true
    # Receives a message from the server.
    m = JSON.parse client.receive

    if m['name'] == 'danopia'
      $message = m['message']
    end

  end
end

1000.times do
  # Connects to Web Socket server at host example.com port 10081.
  clients = (1..5).to_a.map{|x| p x; [x,WebSocket.new("ws://69.195.198.92:8080/server")]}

  5.times do |i|
    clients.each do |c|
      sleep 1
    
      time = Time.now
      time_str = time.strftime('%a %b %d %Y %T GMT%z (EDT)')
      data = {
        :key=>md5.hexdigest("js_#{time_str}"),
        :message=>"#{$message} " * 50,
        #:message=>"Shut up, tester. " * 75,
        #:message=>"<a><a><a><a><a> " * 50,
        :name=>"danobot-#{c[0]}",
        :gravatar=>"b3ad324a454d7b507e34650f24f59493",
        :timestamp=>time.to_i * 1000
      }

      # Sends a message to the server.
      c[1].send(data.to_json)
      
      # Receives a message from the server.
      c[1].receive()
    end
  end
end