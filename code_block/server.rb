# from the book: Ruby Best Practices, http://www.amazon.com/Ruby-Best-Practices-Gregory-Brown/dp/0596523009

require "socket"

class Server
  def initialize(port = 3333)
    @server = TCPServer.new("127.0.0.1", port)
    @handlers = {}
  end

  def handle(pattern, &block)
    @handlers[pattern] = block
  end

  def run
    while session = @server.accept
      msg = session.gets
      puts "Received message: #{msg}"
      match = nil

      @handlers.each do |pattern, block|
        if match = msg.match(pattern)
          break session.puts(block.call(match))
        end
      end

      unless match
        session.puts "Server received unknown message: #{msg}"
      end
    end
  end
end

server = Server.new
server.handle(/hello/i) { "Hello from server at #{Time.now}" }
server.handle(/goodbye/i) { "Goodbye from server at #{Time.now}" }
server.handle(/name is (\w+)/) { |m| "Nice to meet you #{m[1]}!" }
server.run
