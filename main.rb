#!/usr/bin/env ruby

require "bundler/setup"

require "open-uri"
require "nokogiri"
require "kconv"



class MoEGachaCrawler
  WAIT_TIME = 0.6
  attr_accessor :list
  def initialize()
    @list = []
  end
  def get_gacha_list(url = 'https://moepic.com/minigame/moegacha.php')
    gacha_list = []

    html = `curl -s https://moepic.com/minigame/moegacha.php`.toutf8
    page = Nokogiri::HTML(html)
    page.css('div[class=frame-moegacha]').each do |gacha_category|
      gacha = Gacha.new()
      gacha_category.css('div[class=box-gacha-title]').each do |gacha_part|
        # タイトル取得
        gacha_part.css('ul > li[class=area-name] > span > p').each do |title|
          gacha.title = title.text
        end
        # 消費SP取得
        gacha_part.css('ul > li[class=area-sp] > span > p').each do |price|
          gacha.price = price.text
        end
        # ガチャラインナップ取得
        gacha_part.css('ul > li[class=area-list] > a').each do |lineup|
          res = /javascript:item_list\('(.+)'\);/.match(lineup[:href])
          if res.length > 0 then
            gacha_code = res[1]
            lineup_url = "https://moepic.com/minigame/item_list.php?code=#{gacha_code}"
            gacha.lineup_url = lineup_url
          end
        end
      end
      gacha_list << gacha
    end
    @list = gacha_list
  end

  def get_all_gacha_lineup()
    @list.each do|gacha|
      gacha.get_lineup()
      sleep WAIT_TIME 
    end
  end

  def print()
    @list.each do|gacha|
      gacha.print()
    end
  end
end

class Gacha
  attr_accessor :title, :price, :lineup_url, :table, :premium_table
  def initialize()
  end
  # gachaのテーブルリストを返す。複数ある場合は10連用テーブルが存在
  def get_lineup(url = nil)
    if url.nil? then url = @lineup_url end

    table_list = []
    page = Nokogiri::HTML(URI.open(@lineup_url))
    page.css('td[id="ctopcenter"] > div > table').each do |table|
      gacha_table = []
      now_rank = ""
      table.css('tbody > tr').each do |item|
        columns = item.css('td').map(&:text)
        if columns.length > 3 then
          rank, name, count, probability = columns 
          now_rank = rank
        else
          name, count, probability = columns
        end
        gacha_table << GachaItem.new(now_rank, name, count, probability)
      end
      table_list << gacha_table
    end
    
    @table = table_list[0]
    if table_list.length > 1 then 
      # 10連テーブルが存在
      @premium_table = table_list[1]
    end
  end

  def print()
    puts "タイトル：#{@title}"
    puts "消費SP：#{@price}"
    @table.each do|item|
      item.print()
    end
  end
end

class GachaItem
  attr_accessor :rank, :name, :count, :probability
  def initialize(rank,name,count,prob)
    @rank = rank
    @name = name
    @count = count
    @probability = prob
  end
  def print()
    puts "アイテム名：#{@name} 個数：#{@count} 確率：#{@probability}"
  end
end

crawler = MoEGachaCrawler.new()
crawler.get_gacha_list()
crawler.get_all_gacha_lineup()
crawler.print()

