#!/usr/bin/env ruby
require "bundler/setup"

#require "./src/fetch/main.rb"
require "./src/lib/db.rb"


#crawler = MoEGachaCrawler.new()

db = GachaDB.new()

pp db.select_gacha("2023-10-25")
