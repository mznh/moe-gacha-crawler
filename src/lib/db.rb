require 'time'
require 'sqlite3'


class GachaDB 
  @db
  def initialize
    @db = SQLite3::Database.new("db.sqlite3")
    @db.results_as_hash = true
  end

  def insert_gacha(title,time,price) 
    dt = time.strftime("%F")
    query = <<-"EOS"
      insert into 
        gacha(dt,title,price)
        values("#{dt}","#{title}","#{price}");
    EOS
    @db.execute(query)
    @db.execute("select * from gacha where rowid = last_insert_rowid()")
  end

  def insert_item(gacha_id,rank,name,count,probability,is_premium) 
    query = <<-"EOS"
      insert into 
        item(gacha_id,`rank`,name,`count`,probability,is_premium) 
        values("#{gacha_id}","#{rank}","#{name}","#{count}","#{probability}", "#{is_premium}")
    EOS
    @db.execute(query)
    @db.execute("select * from item where rowid = last_insert_rowid()")
  end
end
