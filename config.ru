require './environment'
require './io_improv'

Dir["#{File.dirname(__FILE__)}/lib/*.rb"].sort.each { |file| require file }

use NoWWW

map '/' do
  run IoImprov
end
