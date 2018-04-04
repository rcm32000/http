require 'socket'
require 'pry'

class Server
  def initialize(tcp_server = 9292)
    @tcp_server = TCPServer.new(tcp_server)
    @hello_count = 0
  end

  def run
    loop do
      puts "ready for request"
      client = @tcp_server.accept
      puts "Client" + client.inspect
      request_lines = accept_request(client)
      server_respond(client, request_lines)
    end
  end

  def accept_request(client)
    request_lines = []
    puts "request line creation"
    if line = client.gets
      # binding.pry
      request_lines << line.chomp
      puts "begin until loop"
      until line.empty?
        puts "inside loop"
        line = client.gets.chomp
        request_lines << line
      end
    end
    puts "end loop"
    request_lines
  end

  def server_respond(client, request_lines)
    puts "start server_respond method"
    # request_lines = accept_request(client)
    puts request_lines
    verb = request_lines[0].split[0]
    path = request_lines[0].split[1]
    protocol = request_lines[0].split[2]
    host = request_lines[1].split(":")[1]
    port = request_lines[1].split(":")[2]
    origin = request_lines[1].split(":")[1]
    accept = request_lines[6].split(":")[1]
    puts "about to output"
    headers = ["http/1.1 200 ok"]
    body = "<html><head></head><body><pre>"\
            "Verb: #{verb}\n"\
            "Path: #{path}\n"\
            "Protocol: #{protocol}\n"\
            "Host:#{host}\n"\
            "Port: #{port}\n"\
            "Origin:#{origin}\n"\
            "Accept:#{accept}"\
            "</body></html></pre>"
    greeting = "Hello, World! (#{@hello_count})"
    output = "<html><head></head><body>#{greeting}\n\n#{body}"\
              "</body></html>"
    puts "output and header lines"
    client.puts headers
    client.puts "\n"
    client.puts output
    client.close
    @hello_count += 1
    puts @hello_count
  end
end

server = Server.new
server.run
