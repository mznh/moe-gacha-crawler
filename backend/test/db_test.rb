#!/usr/bin/env ruby
require "bundler/setup"

require "./backend/lib/db.rb"

db = GachaDB.new()
pp db.select_gacha("2023-10-25")
