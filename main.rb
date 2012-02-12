#!/usr/bin/ruby
require './lib/connection'
require './lib/downloader'

#start connection
dw = Downloader::new('user', 'password', 'list.txt');