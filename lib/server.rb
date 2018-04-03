require 'socket'
require 'pry'

class Server
  def initialize(tcp_server = 9292)
    @tcp_server = TCPServer.new(tcp_server)
    @client = @tcp_server.accept
  end

    puts "Ready for a request"
    request_lines = []
    path = request_lines[0].split(" ")[1]
    until path == '/shutdown'
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    puts "Got this request:"
    # binding.pry
    puts request_lines.inspect

    puts "Sending response."
    response = "<pre>" + 'rob' + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output

    puts ["Wrote this response:", headers, output].join("\n")
  end
  client.close
  puts "\nResponse complete, exiting."
end
