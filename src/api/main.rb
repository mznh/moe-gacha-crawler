#!/usr/bin/env ruby
require "bundler/setup"

require "sinatra"
require 'json'
require "./src/lib/db.rb"

set :db, GachaDB.new()


get '/gacha/:dt' do
  res = settings.db.select_gacha(params['dt'])
  res.to_json
end

