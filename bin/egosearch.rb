#!/usr/bin/env ruby
require "rubygems"
require "bundler"
Bundler.require
$:.unshift File.expand_path "../", File.dirname(__FILE__)
require "inits/db"
require "inits/config"
require "models/tweet"
require "libs/crawler"
require "libs/sender"

args = ArgsParser.parse ARGV do
  arg :nosave, "nosave"
  arg :help, "show help", :alias => :h
end

if args.has_option? :help
  STDERR.puts args.help
  exit 1
end

crawler = EgoSearch::Crawler.new :nosave => args.has_option?(:nosave)

crawler.on :crawl do |word, tweet|
  puts "[crawl:#{word}] - #{tweet}"
end

crawler.on :new do |word, tweet|
  puts "[new:#{word}] - #{tweet}"
  EgoSearch::Sender.send "[#{word}] (re)tweeted by @#{tweet.user}\n#{tweet.url}"
end

crawler.on :error do |err|
  STDERR.puts err
end

crawler.start
