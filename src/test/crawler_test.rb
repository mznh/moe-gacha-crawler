#!/usr/bin/env ruby
require "bundler/setup"

require "./src/lib/crawler.rb"

crawler = MoEGachaCrawler.new(single_mode = true)
crawler.get_gacha_list()
crawler.get_all_gacha_lineup()
crawler.print()
