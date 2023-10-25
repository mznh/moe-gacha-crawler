
task :fetch do
  ruby "src/fetch/main.rb"
end

task :api do
  ruby "src/api/main.rb"
end

task :frontend do
  cd "frontend"
  sh "npm run start"
end

namespace :test do
  task :fetch do
    ruby "src/test/crawler_test.rb"
  end

  task :db do
    ruby "src/test/db_test.rb"
  end
end

