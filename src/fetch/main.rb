#!/usr/bin/env ruby
require "bundler/setup"

require "open-uri"
require "nokogiri"
require "kconv"
require "time"

require "./src/lib/crawler.rb"

crawler = MoEGachaCrawler.new()
crawler.get_gacha_list()
crawler.get_all_gacha_lineup()
#crawler.print()

