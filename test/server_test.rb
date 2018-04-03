require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/http'

class ServerTest < Minitest::Test
  def test_it_exists
    server = Server.new(9292)

    assert_instance_of Server, server
  end
end
