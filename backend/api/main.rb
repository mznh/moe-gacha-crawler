#!/usr/bin/env ruby
require "bundler/setup"

require "sinatra"
require 'sinatra/reloader' if development?
require 'haml'
require 'json'
require "./backend/lib/db.rb"

set :db, GachaDB.new()



get '/' do
  @dt_list = settings.db.select_date_list().map {|r| r["dt"]}
  haml :index
end

get '/:dt' do
  @list = settings.db.select_gacha_list(params['dt'])
  p @list
  #res = settings.db.select_gacha_list(params['dt'])
  haml :date
end

get '/gacha/:id' do
  @info = settings.db.select_gacha_info(params['id'])
  @table = settings.db.select_gacha_table(params['id'])
  @normal_table  = @table.filter{|item| not item["is_premium"] == 'true'} 
  @premium_table = @table.filter{|item| item["is_premium"] == 'true'} 

  haml :table
end

get '/api/list/:dt' do
  res = settings.db.select_gacha_list(params['dt'])
  res.to_json
end

get '/api/gacha/:id' do
  res = settings.db.select_gacha_table(params['id'])
  res.to_json
end

