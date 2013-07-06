require "rubygems"
require "bundler"
Bundler.require
$:.unshift File.expand_path "../", File.dirname(__FILE__)
require "inits/db"
require "libs/config"
require "libs/crawler"
require "models/tweet"

crawler = EgoSearch::Crawler.new

crawler.on :crawl do |word, tweet|
  puts "[crawl:#{word}] - #{tweet}"
end

crawler.on :new do |word, tweet|
  puts "[new:#{word}] - #{tweet}"
end

crawler.on :error do |err|
  STDERR.puts err
end

crawler.start
