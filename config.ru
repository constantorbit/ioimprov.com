require 'rubygems'
require 'sinatra'

require 'ioimprov'
require 'lib/nowww'

use NoWWW
run Sinatra::Application