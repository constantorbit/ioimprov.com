require './environment'
require './io_improv'

Dir["#{File.dirname(__FILE__)}/lib/*.rb"].sort.each { |file| require file }

use NoWWW

use Rack::ReverseProxy do
  reverse_proxy '/chicago', 'http://chicago.ioimprov.com/'
  reverse_proxy '/west', 'http://west.ioimprov.com/'
end

map '/' do
  run IoImprov
end
