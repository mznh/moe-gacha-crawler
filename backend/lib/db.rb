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

  def select_date_list() # dt: "yyyy-mm-dd"
    query = "select distinct dt from gacha"
    @db.execute(query)
  end

  def select_gacha_info(id) # dt: "yyyy-mm-dd"
    query = "select * from gacha where id = \"#{id}\""
    @db.execute(query).first
  end

  def select_gacha_list(dt) # dt: "yyyy-mm-dd"
    query = <<-"EOS"
      select 
        * 
      from 
        gacha t1
      inner join (
        select distinct 
          dt,
          created_at as latest_time
        from gacha 
        where dt = "#{dt}" 
        order by created_at desc 
        limit 1
      ) t2
      on t1.dt = t2.dt 
      where 
        t1.dt = "#{dt}" and  
        t1.created_at = t2.latest_time
    EOS
    @db.execute(query)
  end

  def select_gacha_table(gacha_id) # dt: "yyyy-mm-dd"
    query = "select * from item where gacha_id = \"#{gacha_id}\""
    @db.execute(query)
  end
end
