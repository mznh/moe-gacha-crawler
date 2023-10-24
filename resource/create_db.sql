

CREATE TABLE gacha(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  dt TEXT,
  title TEXT,
  price TEXT,
  created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
);

CREATE TABLE item(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  gacha_id INTEGER,
  `rank` TEXT,
  name TEXT,
  `count` TEXT,
  probability TEXT,
  is_premium TEXT,
  created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime'))
);
