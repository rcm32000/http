require 'socket'
tcp_server = TCPServer.new(9292)
@hello_count = 0
loop do
client = tcp_server.accept
request_lines = []
line = client.gets.chomp
until line.empty?
  line = client.gets.chomp
  request_lines << line
end
output = "<html><head></head><body>Hello, World! (#{@hello_count})</body></html>"
headers = ["http/1.1 200 ok"]
client.puts headers
client.puts "\n"
client.puts output
client.close
@hello_count += 1
end
