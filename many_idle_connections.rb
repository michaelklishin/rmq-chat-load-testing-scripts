#!/usr/bin/env ruby

require 'vendor/web_socket'

require 'rubygems'
require 'json'

# Connects to Web Socket server at host example.com port 10081.
clients = (1..100).to_a.map{|x| p x; [x,WebSocket.new("ws://69.195.198.92:8080/server")]}

while true
  clients.each do |c|
    sleep 1
  
    # Receives a message from the server.
    c[1].receive()
  end
end