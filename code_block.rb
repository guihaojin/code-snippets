# from the book: Ruby Best Practices, http://www.amazon.com/Ruby-Best-Practices-Gregory-Brown/dp/0596523009

require "socket"

class Client
  def initialize(ip = "127.0.0.1", port = 3333)
    @ip, @port = ip, port
  end

  def send_message(msg)
    connection do |socket|
      socket.put(msg)
      socket.gets
    end
  end

  def receive_message
    connection do |socket|
      socket.gets
    end
  end

  private

  def connection
    socket = TCPSocket.new(@ip, @port)
    yield(socket)
  ensure
    socket.close
  end
end
