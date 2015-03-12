
require_relative 'Chattur.config.rb' # The config for this
require 'socket'      # Sockets are in standard library
require 'thread'


class Chattur
	@@connected = false

	def initialize
		puts"Starting Chattur!"
		@server_socket = TCPServer.open(HOST_PORT)
		@listner_thread = Thread.new{listener}
		main
		puts "startup complete"
	end

	def main
		loop do
			puts "Do you want to send a message? type \"message\""
			puts "Do you want to exit? type \"exit\""
			puts "Do you want to exit? type \"conection\""  
			
			input = gets.chomp
			case input
		        when "exit"
	            	puts "Bye!"
	            	close_connection
	            	break

	            when "message"
	            	unless @@connected == true
	            		puts "there is no connection to another chat client!"	            		
   	            	else
   	            		puts "What is your message?"
            			msg = gets
            			send_message(msg)	            		
	            	end

	            when "connection"
	            	puts"Target IP Adress: "
	            	target_ip = gets
	            	puts "Target_port: "
	            	port = gets
	            	set_connection(target_ip, port)
	            	@connected = true
	            else
	            	puts "helemaal niks nog"
			end	
		end            	
	end
	def listener
		puts "listener thread started!"
		while line = @listener_socket.gets   
			puts "Partner said: #{line.chop}"
		end   				
	end

	def send_message(message)

		client = @server_socket.accept
		client.puts(message)
	end

	def set_connection(tar_address, tar_port)
		@listener_socket = TCPSocket.open(tar_address, tar_port)
	end

	def close_connection
		@listner_thread.exit
		@sender_thread.exit
		@server_socket.close
		@listener_socket.close
	end

end