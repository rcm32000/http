require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require 'socket'
require 'pry'
require './lib/server'

class ServerTest < Minitest::Test
  def test_it_exists
    server = Server.new(9292)

    assert_instance_of Server, server
    server.tcp_server.close
  end

  def test_accept_request
    server = Faraday.get 'http://127.0.0.1:9292/'

    assert_equal @client, server.accept
    server.tcp_server.close
  end

  def test_headers
    skip
    server = Server.new(9292)
    response = '200 ok'
    output = 'Testing'

    assert server(response, output).include?('ruby')
  end
end
