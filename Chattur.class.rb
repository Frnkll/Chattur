
require 'Chattur.config.rb' # The config for this
require 'socket'      # Sockets are in standard library
require 'thread'


class Chattur

	def initialize
		puts"Starting Chattur!"
		@listener_socket = TCPSocket.open(TARGET_ADRESS,TARGET_PORT)
		@server_socket = TCPServer.open(HOST_PORT)
		@listner_thread = Thread.new{ loop do listener end }
		@sender_thread = Thread.new{ loop do sender end }	


	end

	def listener

		while line = @listener_socket.gets   # Read lines from the socket
			puts line.chop      				 # And print with platform line terminator
		end		
		puts "listening to: #{TARGET_ADRESS} on port: #{TARGET_PORT}"
	end

	def sender
		
	end
end