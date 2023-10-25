require 'time'
require 'sqlite3'


class GachaDB 
  DATABASE_FILE_NAME = "db.sqlite3"
  def initialize
    @db = SQLite3::Database.new(DATABASE_FILE_NAME)
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

  def select_gacha(dt) # dt: "yyyy-mm-dd"
    query = "select * from gacha where dt = \"#{dt}\""
    @db.execute(query)
  end
end
